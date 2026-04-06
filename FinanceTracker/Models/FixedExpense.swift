import Foundation
import SwiftData

@Model
final class FixedExpense {
    @Attribute(.unique) var id: UUID
    var name: String
    var annualAmount: Double
    var frequency: String
    var categoryIcon: String
    var categoryColorHex: String
    var startDate: Date
    var endDate: Date?
    var isActive: Bool
    var note: String

    init(
        name: String,
        annualAmount: Double,
        frequency: String = "monthly",
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

    var monthlyAmount: Double {
        annualAmount / 12.0
    }

    var quarterlyAmount: Double {
        annualAmount / 4.0
    }

    var formattedMonthly: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_SG")
        return formatter.string(from: NSNumber(value: monthlyAmount)) ?? "$0.00"
    }

    enum Frequency: String, CaseIterable {
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

        var divisor: Double {
            switch self {
            case .monthly: return 12
            case .quarterly: return 4
            case .semiAnnual: return 2
            case .annual: return 1
            }
        }
    }
}
