import SwiftUI

// MARK: - Date Extensions

extension Date {
    var startOfMonth: Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    }

    var endOfMonth: Date {
        Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
    }

    var startOfYear: Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.year], from: self))!
    }

    var monthName: String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMM")
        return formatter.string(from: self)
    }

    var dayString: String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("d")
        return formatter.string(from: self)
    }

    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    var isThisMonth: Bool {
        let calendar = Calendar.current
        return calendar.component(.month, from: self) == calendar.component(.month, from: Date()) &&
               calendar.component(.year, from: self) == calendar.component(.year, from: Date())
    }
}

// MARK: - Currency Formatter (cached, M1: respects user currency setting)

enum CurrencyConfig {
    private static var _formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: UserDefaults.standard.string(forKey: "currencyLocale") ?? "en_SG")
        return formatter
    }()

    static var formatter: NumberFormatter { _formatter }

    static func updateLocale(_ localeIdentifier: String) {
        UserDefaults.standard.set(localeIdentifier, forKey: "currencyLocale")
        _formatter.locale = Locale(identifier: localeIdentifier)
    }
}

// MARK: - Decimal Extensions

extension Decimal {
    var currencyString: String {
        CurrencyConfig.formatter.string(from: self as NSDecimalNumber) ?? "$0.00"
    }

    var shortCurrencyString: String {
        if self >= 10000 {
            let thousands = NSDecimalNumber(decimal: self / 1000).doubleValue
            return String(format: "$%.1fK", thousands)
        }
        return currencyString
    }

    var doubleValue: Double {
        NSDecimalNumber(decimal: self).doubleValue
    }
}

// MARK: - Double Extensions (display-only, for Views that receive Double)

extension Double {
    var currencyString: String {
        Decimal(self).currencyString
    }
}

// MARK: - View Extensions

extension View {
    func hideKeyboard() {
        #if canImport(UIKit)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        #endif
    }

    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

// MARK: - Expense Aggregation (M4: shared between HomeView and AnalysisViewModel)

struct CategoryBreakdownItem {
    let name: String
    let icon: String
    let colorHex: String
    let amount: Decimal
    let count: Int
}

extension Array where Element == Expense {
    func categoryBreakdown(isIncome: Bool = false) -> [CategoryBreakdownItem] {
        let filtered = self.filter { $0.isIncome == isIncome }
        var grouping: [String: (icon: String, colorHex: String, amount: Decimal, count: Int)] = [:]

        for expense in filtered {
            let name = expense.category?.localizedName ?? L("未分类")
            let icon = expense.category?.icon ?? "ellipsis.circle.fill"
            let colorHex = expense.category?.colorHex ?? "BDBDBD"
            let existing = grouping[name] ?? (icon: icon, colorHex: colorHex, amount: Decimal.zero, count: 0)
            grouping[name] = (icon: icon, colorHex: colorHex, amount: existing.amount + expense.amount, count: existing.count + 1)
        }

        return grouping.map { (name, data) in
            CategoryBreakdownItem(name: name, icon: data.icon, colorHex: data.colorHex, amount: data.amount, count: data.count)
        }
        .sorted { $0.amount > $1.amount }
    }

    func total(isIncome: Bool) -> Decimal {
        self.filter { $0.isIncome == isIncome }.reduce(Decimal.zero) { $0 + $1.amount }
    }
}

// MARK: - Animation Extensions

extension Animation {
    static let m3Standard = Animation.spring(response: 0.3, dampingFraction: 0.82)
    static let m3Emphasized = Animation.spring(response: 0.5, dampingFraction: 0.7)
    static let m3EmphasizedDecelerate = Animation.spring(response: 0.4, dampingFraction: 0.9)
}
