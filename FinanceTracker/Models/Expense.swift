import Foundation
import SwiftData

@Model
final class Expense {
    @Attribute(.unique) var id: UUID
    var amount: Decimal
    var note: String
    var date: Date
    var isIncome: Bool
    var receiptImageData: Data?
    var sourceType: SourceType
    var createdAt: Date

    @Relationship var category: ExpenseCategory?
    @Relationship var account: Account?
    @Relationship(inverse: \User.expenses) var user: User?

    init(
        amount: Decimal,
        note: String = "",
        date: Date = Date(),
        isIncome: Bool = false,
        category: ExpenseCategory? = nil,
        account: Account? = nil,
        receiptImageData: Data? = nil,
        sourceType: SourceType = .manual
    ) {
        self.id = UUID()
        self.amount = amount
        self.note = note
        self.date = date
        self.isIncome = isIncome
        self.category = category
        self.account = account
        self.receiptImageData = receiptImageData
        self.sourceType = sourceType
        self.createdAt = Date()
    }

    var formattedAmount: String {
        amount.currencyString
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMdd HHmm")
        return formatter.string(from: date)
    }
}

// MARK: - Source types

extension Expense {
    enum SourceType: String, CaseIterable, Codable {
        case manual = "manual"
        case camera = "camera"
        case ocr = "ocr"
        case fileImport = "file_import"
        case wechat = "wechat"
        case voice = "voice"
        case screenshot = "screenshot"

        var displayName: String {
            switch self {
            case .manual: return L("手动输入")
            case .camera: return L("拍照记账")
            case .ocr: return L("OCR识别")
            case .fileImport: return L("文件导入")
            case .wechat: return L("微信导入")
            case .voice: return L("语音记账")
            case .screenshot: return L("截图记账")
            }
        }

        var icon: String {
            switch self {
            case .manual: return "square.and.pencil"
            case .camera: return "camera.fill"
            case .ocr: return "doc.text.viewfinder"
            case .fileImport: return "doc.fill"
            case .wechat: return "message.fill"
            case .voice: return "mic.fill"
            case .screenshot: return "photo.fill"
            }
        }
    }
}
