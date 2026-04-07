import Foundation
#if os(iOS)
import UIKit
import PDFKit
#endif

actor OpenAIOCRService {
    static let shared = OpenAIOCRService()

    private let apiKeyKey = "openai_api_key"
    private let baseURL = "https://api.openai.com/v1/chat/completions"

    var hasAPIKey: Bool {
        !(apiKey ?? "").isEmpty
    }

    var apiKey: String? {
        get { UserDefaults.standard.string(forKey: apiKeyKey) }
    }

    func setAPIKey(_ key: String) {
        UserDefaults.standard.set(key, forKey: apiKeyKey)
    }

    func removeAPIKey() {
        UserDefaults.standard.removeObject(forKey: apiKeyKey)
    }

    // MARK: - Test API Key

    enum APIKeyTestResult {
        case valid
        case invalid
        case networkError(String)
    }

    func testAPIKey() async -> APIKeyTestResult {
        guard let key = apiKey, !key.isEmpty else {
            return .invalid
        }

        let requestBody: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [["role": "user", "content": "Hi"]],
            "max_tokens": 1
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
            var request = URLRequest(url: URL(string: baseURL)!)
            request.httpMethod = "POST"
            request.setValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            request.timeoutInterval = 15

            let (_, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                return .networkError(L("无法连接到服务器"))
            }

            if httpResponse.statusCode == 200 {
                return .valid
            } else if httpResponse.statusCode == 401 {
                return .invalid
            } else {
                return .networkError("HTTP \(httpResponse.statusCode)")
            }
        } catch {
            return .networkError(error.localizedDescription)
        }
    }

    // MARK: - Chat Completion (text-only)

    private func chatCompletion(prompt: String, userContent: String) async throws -> String {
        guard let key = apiKey, !key.isEmpty else {
            throw OpenAIError.noAPIKey
        }

        let requestBody: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [
                ["role": "system", "content": prompt],
                ["role": "user", "content": userContent]
            ],
            "max_tokens": 2000,
            "temperature": 0.1
        ]

        let (data, statusCode) = try await performRequest(key: key, body: requestBody)

        if statusCode == 401 { throw OpenAIError.invalidAPIKey }
        guard statusCode == 200 else {
            let errorBody = String(data: data, encoding: .utf8) ?? ""
            throw OpenAIError.apiError(statusCode: statusCode, message: errorBody)
        }

        return try extractContent(from: data)
    }

    // MARK: - Category Matching

    func suggestCategory(for description: String, isIncome: Bool, categories: [String]) async -> String? {
        guard !categories.isEmpty, !description.isEmpty else { return nil }
        guard let key = apiKey, !key.isEmpty else { return nil }

        let list = categories.joined(separator: "、")
        let prompt = """
        你是一个记账分类助手。根据消费/收入描述，从给定的分类列表中选择最匹配的一个。
        只返回分类名称，不要返回任何其他文字。如果都不匹配，返回"其他"。
        分类列表：\(list)
        """

        let requestBody: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [
                ["role": "system", "content": prompt],
                ["role": "user", "content": description]
            ],
            "max_tokens": 20,
            "temperature": 0
        ]

        do {
            let (data, statusCode) = try await performRequest(key: key, body: requestBody)
            guard statusCode == 200 else { return nil }
            let result = try extractContent(from: data)
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .trimmingCharacters(in: CharacterSet(charactersIn: "\""))
            return result.isEmpty ? nil : result
        } catch {
            return nil
        }
    }

    // MARK: - Parse Expense from Voice/Text

    struct ParsedExpenseResult {
        let amount: Decimal?
        let note: String?
        let isIncome: Bool
    }

    func parseExpenseFromText(_ text: String) async throws -> ParsedExpenseResult {
        let prompt = """
        你是一个记账助手。用户通过语音或文字输入了一笔消费/收入。请从中提取信息。
        严格按以下JSON格式返回，不要包含其他文字：
        {
          "amount": 数字,
          "note": "简短描述这笔开支/收入",
          "is_income": false
        }
        注意：
        - amount 只返回正数数字，不要货币符号
        - note 应该是简洁的中文或英文描述（保持用户原有语言）
        - is_income: 只有明确是收入才为true（如工资、转入、红包收入等）
        - 如果无法提取金额，amount 返回 null
        """

        let content = try await chatCompletion(prompt: prompt, userContent: text)
        let clean = content
            .replacingOccurrences(of: "```json", with: "")
            .replacingOccurrences(of: "```", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard let data = clean.data(using: .utf8),
              let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw OpenAIError.parseError
        }

        let amount: Decimal? = {
            if let num = json["amount"] as? Double, num > 0 { return Decimal(num) }
            if let num = json["amount"] as? Int, num > 0 { return Decimal(num) }
            return nil
        }()

        return ParsedExpenseResult(
            amount: amount,
            note: json["note"] as? String,
            isIncome: json["is_income"] as? Bool ?? false
        )
    }

    // MARK: - Parse Multiple Expenses from Document Text

    struct ParsedDocumentExpense {
        let amount: Decimal
        let note: String
        let date: String?
        let isIncome: Bool
    }

    func parseExpensesFromDocumentText(_ text: String) async throws -> [ParsedDocumentExpense] {
        let prompt = """
        你是一个记账助手。用户提供了一段账单/收据/财务文档的文字内容。
        请从中提取所有消费/收入记录。
        严格按以下JSON格式返回，不要包含其他文字：
        {
          "expenses": [
            {
              "amount": 数字,
              "note": "简短描述",
              "date": "YYYY-MM-DD或null",
              "is_income": false
            }
          ]
        }
        注意：
        - amount只返回正数数字
        - 如果金额都很小（如个别商品），也一一列出
        - 如果有合计/总计行，单独作为一条记录，note标注"合计"
        - date格式 YYYY-MM-DD，无法确定则null
        - 如果完全无法提取任何金额信息，返回空数组
        """

        let content = try await chatCompletion(prompt: prompt, userContent: text)
        let clean = content
            .replacingOccurrences(of: "```json", with: "")
            .replacingOccurrences(of: "```", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard let data = clean.data(using: .utf8),
              let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let expensesArray = json["expenses"] as? [[String: Any]] else {
            throw OpenAIError.parseError
        }

        return expensesArray.compactMap { item in
            var amount: Decimal = 0
            if let num = item["amount"] as? Double { amount = Decimal(num) }
            else if let num = item["amount"] as? Int { amount = Decimal(num) }
            guard amount > 0 else { return nil }

            return ParsedDocumentExpense(
                amount: amount,
                note: item["note"] as? String ?? "",
                date: item["date"] as? String,
                isIncome: item["is_income"] as? Bool ?? false
            )
        }
    }

    // MARK: - Extract Expenses from PDF/Image

    #if os(iOS)
    func extractExpensesFromImages(_ images: [UIImage]) async throws -> [ParsedDocumentExpense] {
        guard let key = apiKey, !key.isEmpty else {
            throw OpenAIError.noAPIKey
        }

        var imageContents: [[String: Any]] = []
        for image in images {
            guard let imageData = image.jpegData(compressionQuality: 0.6) else { continue }
            let base64 = imageData.base64EncodedString()
            imageContents.append([
                "type": "image_url",
                "image_url": ["url": "data:image/jpeg;base64,\(base64)", "detail": "high"]
            ])
        }

        guard !imageContents.isEmpty else { throw OpenAIError.invalidImage }

        let prompt = """
        你是一个记账助手。请仔细分析这些图片（可能是PDF页面、账单、银行对账单、收据等），
        提取所有消费和收入记录。
        严格按以下JSON格式返回，不要包含其他文字：
        {
          "expenses": [
            {
              "amount": 数字,
              "note": "简短描述",
              "date": "YYYY-MM-DD或null",
              "is_income": false
            }
          ]
        }
        注意：
        - amount只返回正数数字，不要货币符号
        - 逐条列出每笔交易
        - date格式 YYYY-MM-DD，无法确定则null
        - is_income: 收入/转入为true，支出为false
        """

        var contentArray: [[String: Any]] = [["type": "text", "text": prompt]]
        contentArray.append(contentsOf: imageContents)

        let requestBody: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [["role": "user", "content": contentArray]],
            "max_tokens": 4000,
            "temperature": 0.1
        ]

        let (data, statusCode) = try await performRequest(key: key, body: requestBody)

        if statusCode == 401 { throw OpenAIError.invalidAPIKey }
        guard statusCode == 200 else {
            let errorBody = String(data: data, encoding: .utf8) ?? ""
            throw OpenAIError.apiError(statusCode: statusCode, message: errorBody)
        }

        let content = try extractContent(from: data)
        let clean = content
            .replacingOccurrences(of: "```json", with: "")
            .replacingOccurrences(of: "```", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard let jsonData = clean.data(using: .utf8),
              let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
              let expensesArray = json["expenses"] as? [[String: Any]] else {
            throw OpenAIError.parseError
        }

        return expensesArray.compactMap { item in
            var amount: Decimal = 0
            if let num = item["amount"] as? Double { amount = Decimal(num) }
            else if let num = item["amount"] as? Int { amount = Decimal(num) }
            guard amount > 0 else { return nil }

            return ParsedDocumentExpense(
                amount: amount,
                note: item["note"] as? String ?? "",
                date: item["date"] as? String,
                isIncome: item["is_income"] as? Bool ?? false
            )
        }
    }

    static func renderPDFToImages(url: URL) -> [UIImage] {
        guard let document = PDFDocument(url: url) else { return [] }
        var images: [UIImage] = []
        let pageCount = min(document.pageCount, 10)

        for i in 0..<pageCount {
            guard let page = document.page(at: i) else { continue }
            let bounds = page.bounds(for: .mediaBox)
            let scale: CGFloat = 2.0
            let size = CGSize(width: bounds.width * scale, height: bounds.height * scale)

            let renderer = UIGraphicsImageRenderer(size: size)
            let image = renderer.image { ctx in
                UIColor.white.set()
                ctx.fill(CGRect(origin: .zero, size: size))
                ctx.cgContext.translateBy(x: 0, y: size.height)
                ctx.cgContext.scaleBy(x: scale, y: -scale)
                page.draw(with: .mediaBox, to: ctx.cgContext)
            }
            images.append(image)
        }
        return images
    }

    func extractReceiptInfo(from image: UIImage) async throws -> ReceiptResult {
        guard let key = apiKey, !key.isEmpty else {
            throw OpenAIError.noAPIKey
        }
        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            throw OpenAIError.invalidImage
        }

        let base64Image = imageData.base64EncodedString()
        let prompt = """
        你是一个收据/账单识别助手。请仔细分析这张图片，提取以下信息：
        1. 总金额（如果有的话）
        2. 每个消费项目的名称和金额
        3. 商家名称（如果能识别）
        4. 日期（如果能识别）

        请严格按照以下JSON格式返回，不要包含其他文字：
        {
          "total": 数字或null,
          "merchant": "商家名称或null",
          "date": "YYYY-MM-DD格式或null",
          "items": [
            {"name": "项目名称", "amount": 数字}
          ],
          "summary": "一句话描述这笔消费"
        }

        注意：
        - 金额只返回数字，不要包含货币符号
        - 如果无法识别某个字段，返回null
        - items数组至少返回一个项目
        - 如果图片不是收据/账单，仍然尽力提取金额相关信息
        """

        let requestBody: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [
                [
                    "role": "user",
                    "content": [
                        [
                            "type": "text",
                            "text": prompt
                        ],
                        [
                            "type": "image_url",
                            "image_url": [
                                "url": "data:image/jpeg;base64,\(base64Image)",
                                "detail": "high"
                            ]
                        ]
                    ]
                ]
            ],
            "max_tokens": 1000,
            "temperature": 0.1
        ]

        let jsonData = try JSONSerialization.data(withJSONObject: requestBody)

        var request = URLRequest(url: URL(string: baseURL)!)
        request.httpMethod = "POST"
        request.setValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        request.timeoutInterval = 30

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw OpenAIError.networkError
        }

        if httpResponse.statusCode == 401 {
            throw OpenAIError.invalidAPIKey
        }

        guard httpResponse.statusCode == 200 else {
            let errorBody = String(data: data, encoding: .utf8) ?? ""
            throw OpenAIError.apiError(statusCode: httpResponse.statusCode, message: errorBody)
        }

        return try parseReceiptResponse(data)
    }
    #endif

    // MARK: - Shared Networking

    private func performRequest(key: String, body: [String: Any]) async throws -> (Data, Int) {
        let jsonData = try JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: URL(string: baseURL)!)
        request.httpMethod = "POST"
        request.setValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        request.timeoutInterval = 60

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw OpenAIError.networkError
        }
        return (data, httpResponse.statusCode)
    }

    private func extractContent(from data: Data) throws -> String {
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let choices = json["choices"] as? [[String: Any]],
              let firstChoice = choices.first,
              let message = firstChoice["message"] as? [String: Any],
              let content = message["content"] as? String else {
            throw OpenAIError.parseError
        }
        return content
    }

    private func parseReceiptResponse(_ data: Data) throws -> ReceiptResult {
        let content = try extractContent(from: data)

        let cleanContent = content
            .replacingOccurrences(of: "```json", with: "")
            .replacingOccurrences(of: "```", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard let contentData = cleanContent.data(using: .utf8),
              let result = try JSONSerialization.jsonObject(with: contentData) as? [String: Any] else {
            throw OpenAIError.parseError
        }

        let total: Decimal? = {
            if let num = result["total"] as? Double, num > 0 {
                return Decimal(num)
            }
            if let num = result["total"] as? Int, num > 0 {
                return Decimal(num)
            }
            return nil
        }()

        let merchant = result["merchant"] as? String
        let dateStr = result["date"] as? String
        let summary = result["summary"] as? String

        var items: [ReceiptItem] = []
        if let itemsArray = result["items"] as? [[String: Any]] {
            for item in itemsArray {
                let name = item["name"] as? String ?? ""
                var amount: Decimal = 0
                if let num = item["amount"] as? Double {
                    amount = Decimal(num)
                } else if let num = item["amount"] as? Int {
                    amount = Decimal(num)
                }
                if !name.isEmpty {
                    items.append(ReceiptItem(name: name, amount: amount))
                }
            }
        }

        return ReceiptResult(
            total: total,
            merchant: merchant,
            date: dateStr,
            items: items,
            summary: summary
        )
    }

    enum OpenAIError: LocalizedError {
        case noAPIKey
        case invalidAPIKey
        case invalidImage
        case networkError
        case apiError(statusCode: Int, message: String)
        case parseError

        var errorDescription: String? {
            switch self {
            case .noAPIKey: return L("未配置OpenAI API Key")
            case .invalidAPIKey: return L("API Key无效，请检查设置")
            case .invalidImage: return L("无法处理图片")
            case .networkError: return L("网络连接失败")
            case .apiError(let code, _): return L("API请求失败") + " (\(code))"
            case .parseError: return L("解析识别结果失败")
            }
        }
    }
}

struct ReceiptResult {
    let total: Decimal?
    let merchant: String?
    let date: String?
    let items: [ReceiptItem]
    let summary: String?
}
