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

// MARK: - Double Extensions

extension Double {
    var currencyString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_SG")
        return formatter.string(from: NSNumber(value: self)) ?? "$0.00"
    }

    var shortCurrencyString: String {
        if self >= 10000 {
            return String(format: "$%.1fK", self / 10000)
        }
        return currencyString
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

// MARK: - Animation Extensions

extension Animation {
    static let m3Standard = Animation.spring(response: 0.3, dampingFraction: 0.82)
    static let m3Emphasized = Animation.spring(response: 0.5, dampingFraction: 0.7)
    static let m3EmphasizedDecelerate = Animation.spring(response: 0.4, dampingFraction: 0.9)
}
