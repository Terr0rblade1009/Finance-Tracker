import Foundation
import SwiftData

@Model
final class Account {
    @Attribute(.unique) var id: UUID
    var name: String
    var icon: String
    var colorHex: String
    var balance: Decimal
    var accountType: AccountType
    var sortOrder: Int
    var isArchived: Bool

    @Relationship(deleteRule: .nullify) var expenses: [Expense]?
    @Relationship(inverse: \User.accounts) var user: User?

    init(
        name: String,
        icon: String,
        colorHex: String,
        balance: Decimal = 0,
        accountType: AccountType = .cash,
        sortOrder: Int = 0
    ) {
        self.id = UUID()
        self.name = name
        self.icon = icon
        self.colorHex = colorHex
        self.balance = balance
        self.accountType = accountType
        self.sortOrder = sortOrder
        self.isArchived = false
    }

    enum AccountType: String, CaseIterable, Codable {
        case cash = "cash"
        case bankCard = "bank_card"
        case creditCard = "credit_card"
        case alipay = "alipay"
        case wechatPay = "wechat_pay"
        case investment = "investment"
        case other = "other"

        var displayName: String {
            switch self {
            case .cash: return L("现金")
            case .bankCard: return L("银行卡")
            case .creditCard: return L("信用卡")
            case .alipay: return L("支付宝")
            case .wechatPay: return L("微信支付")
            case .investment: return L("投资账户")
            case .other: return L("其他")
            }
        }

        var icon: String {
            switch self {
            case .cash: return "banknote.fill"
            case .bankCard: return "creditcard.fill"
            case .creditCard: return "creditcard.trianglebadge.exclamationmark"
            case .alipay: return "a.circle.fill"
            case .wechatPay: return "message.fill"
            case .investment: return "chart.line.uptrend.xyaxis"
            case .other: return "wallet.pass.fill"
            }
        }

        var colorHex: String {
            switch self {
            case .cash: return "66BB6A"
            case .bankCard: return "42A5F5"
            case .creditCard: return "EF5350"
            case .alipay: return "1677FF"
            case .wechatPay: return "07C160"
            case .investment: return "FFA726"
            case .other: return "78909C"
            }
        }
    }

    var localizedName: String {
        accountType.displayName
    }

    static func defaultAccounts() -> [Account] {
        [
            Account(name: "现金", icon: "banknote.fill", colorHex: "66BB6A", accountType: .cash, sortOrder: 0),
            Account(name: "银行卡", icon: "creditcard.fill", colorHex: "42A5F5", accountType: .bankCard, sortOrder: 1),
            Account(name: "支付宝", icon: "a.circle.fill", colorHex: "1677FF", accountType: .alipay, sortOrder: 2),
            Account(name: "微信支付", icon: "message.fill", colorHex: "07C160", accountType: .wechatPay, sortOrder: 3),
        ]
    }
}
