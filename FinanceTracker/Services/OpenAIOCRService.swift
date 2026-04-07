import Foundation
#if os(iOS)
import UIKit
#endif

actor OpenAIOCRService {
    static let shared = OpenAIOCRService()

    private let apiKeyKey = "openai_api_key"

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

    #if os(iOS)
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

        var request = URLRequest(url: URL(string: "https://api.openai.com/v1/chat/completions")!)
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

        return try parseResponse(data)
    }
    #endif

    private func parseResponse(_ data: Data) throws -> ReceiptResult {
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let choices = json["choices"] as? [[String: Any]],
              let firstChoice = choices.first,
              let message = firstChoice["message"] as? [String: Any],
              let content = message["content"] as? String else {
            throw OpenAIError.parseError
        }

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
