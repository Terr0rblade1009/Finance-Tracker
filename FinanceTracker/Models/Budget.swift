import Foundation
import SwiftData

@Model
final class Budget {
    @Attribute(.unique) var id: UUID
    var amount: Decimal
    var period: Period
    var startDate: Date
    var isActive: Bool

    @Relationship var category: ExpenseCategory?
    @Relationship(inverse: \User.budgets) var user: User?

    init(
        amount: Decimal,
        period: Period = .monthly,
        startDate: Date = Date(),
        category: ExpenseCategory? = nil
    ) {
        self.id = UUID()
        self.amount = amount
        self.period = period
        self.startDate = startDate
        self.category = category
        self.isActive = true
    }

    enum Period: String, CaseIterable, Codable {
        case weekly = "weekly"
        case monthly = "monthly"
        case quarterly = "quarterly"
        case yearly = "yearly"

        var displayName: String {
            switch self {
            case .weekly: return L("每周")
            case .monthly: return L("每月")
            case .quarterly: return L("每季")
            case .yearly: return L("每年")
            }
        }
    }
}
