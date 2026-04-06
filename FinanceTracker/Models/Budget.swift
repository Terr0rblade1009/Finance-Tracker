import Foundation
import SwiftData

@Model
final class Budget {
    @Attribute(.unique) var id: UUID
    var amount: Double
    var period: String
    var startDate: Date
    var categoryId: UUID?
    var isActive: Bool

    @Relationship(inverse: \User.budgets) var user: User?

    init(
        amount: Double,
        period: String = "monthly",
        startDate: Date = Date(),
        categoryId: UUID? = nil
    ) {
        self.id = UUID()
        self.amount = amount
        self.period = period
        self.startDate = startDate
        self.categoryId = categoryId
        self.isActive = true
    }

    enum Period: String, CaseIterable {
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
