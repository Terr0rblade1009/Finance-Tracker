import Foundation
import SwiftData

@Model
final class FixedExpense {
    @Attribute(.unique) var id: UUID
    var name: String
    var annualAmount: Decimal
    var frequency: Frequency
    var categoryIcon: String
    var categoryColorHex: String
    var startDate: Date
    var endDate: Date?
    var isActive: Bool
    var note: String

    init(
        name: String,
        annualAmount: Decimal,
        frequency: Frequency = .annual,
        categoryIcon: String = "repeat.circle.fill",
        categoryColorHex: String = "90A4AE",
        startDate: Date = Date(),
        endDate: Date? = nil,
        note: String = ""
    ) {
        self.id = UUID()
        self.name = name
        self.annualAmount = annualAmount
        self.frequency = frequency
        self.categoryIcon = categoryIcon
        self.categoryColorHex = categoryColorHex
        self.startDate = startDate
        self.endDate = endDate
        self.isActive = true
        self.note = note
    }

    /// M6: Uses frequency divisor instead of hardcoded /12
    var monthlyAmount: Decimal {
        annualAmount / 12
    }

    var periodAmount: Decimal {
        annualAmount / frequency.divisor
    }

    var quarterlyAmount: Decimal {
        annualAmount / 4
    }

    var formattedMonthly: String {
        monthlyAmount.currencyString
    }

    var formattedPeriodAmount: String {
        periodAmount.currencyString
    }

    enum Frequency: String, CaseIterable, Codable {
        case monthly = "monthly"
        case quarterly = "quarterly"
        case semiAnnual = "semi_annual"
        case annual = "annual"

        var displayName: String {
            switch self {
            case .monthly: return L("每月")
            case .quarterly: return L("每季")
            case .semiAnnual: return L("半年")
            case .annual: return L("每年")
            }
        }

        var divisor: Decimal {
            switch self {
            case .monthly: return 12
            case .quarterly: return 4
            case .semiAnnual: return 2
            case .annual: return 1
            }
        }
    }
}
