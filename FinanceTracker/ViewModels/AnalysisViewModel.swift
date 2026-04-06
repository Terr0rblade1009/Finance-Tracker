import Foundation
import SwiftData

@Observable
class AnalysisViewModel {
    var period: AnalysisPeriod = .monthly
    var expenses: [Expense] = []
    var totalExpense: Double = 0
    var totalIncome: Double = 0
    var categoryBreakdown: [CategorySummary] = []
    var dailyTrend: [DailyAmount] = []

    struct CategorySummary: Identifiable {
        let id = UUID()
        let categoryName: String
        let categoryIcon: String
        let categoryColorHex: String
        let amount: Double
        let percentage: Double
        let count: Int
    }

    struct DailyAmount: Identifiable {
        let id = UUID()
        let date: Date
        let expense: Double
        let income: Double
    }

    func loadData(modelContext: ModelContext) throws {
        let calendar = Calendar.current
        let now = Date()
        let (startDate, endDate) = dateRange(for: period, from: now, calendar: calendar)

        let descriptor = FetchDescriptor<Expense>(
            predicate: #Predicate { $0.date >= startDate && $0.date < endDate },
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )

        expenses = try modelContext.fetch(descriptor)

        totalExpense = expenses.filter { !$0.isIncome }.reduce(0) { $0 + $1.amount }
        totalIncome = expenses.filter { $0.isIncome }.reduce(0) { $0 + $1.amount }

        buildCategoryBreakdown()
        buildDailyTrend(calendar: calendar, startDate: startDate, endDate: endDate)
    }

    private func buildCategoryBreakdown() {
        let expenseItems = expenses.filter { !$0.isIncome }
        var grouping: [String: (icon: String, colorHex: String, amount: Double, count: Int)] = [:]

        for expense in expenseItems {
            let name = expense.category?.localizedName ?? L("其他")
            let icon = expense.category?.icon ?? "ellipsis.circle.fill"
            let colorHex = expense.category?.colorHex ?? "BDBDBD"
            let existing = grouping[name] ?? (icon: icon, colorHex: colorHex, amount: 0, count: 0)
            grouping[name] = (icon: icon, colorHex: colorHex, amount: existing.amount + expense.amount, count: existing.count + 1)
        }

        let total = max(totalExpense, 1)
        categoryBreakdown = grouping.map { (name, data) in
            CategorySummary(
                categoryName: name,
                categoryIcon: data.icon,
                categoryColorHex: data.colorHex,
                amount: data.amount,
                percentage: (data.amount / total) * 100,
                count: data.count
            )
        }
        .sorted { $0.amount > $1.amount }
    }

    private func buildDailyTrend(calendar: Calendar, startDate: Date, endDate: Date) {
        var current = startDate
        var trend: [DailyAmount] = []

        while current < endDate {
            let dayEnd = calendar.date(byAdding: .day, value: 1, to: current)!
            let dayExpenses = expenses.filter { $0.date >= current && $0.date < dayEnd }

            let dayExpense = dayExpenses.filter { !$0.isIncome }.reduce(0) { $0 + $1.amount }
            let dayIncome = dayExpenses.filter { $0.isIncome }.reduce(0) { $0 + $1.amount }

            if dayExpense > 0 || dayIncome > 0 {
                trend.append(DailyAmount(date: current, expense: dayExpense, income: dayIncome))
            }
            current = dayEnd
        }

        dailyTrend = trend
    }

    private func dateRange(for period: AnalysisPeriod, from date: Date, calendar: Calendar) -> (Date, Date) {
        switch period {
        case .monthly:
            let start = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
            let end = calendar.date(byAdding: .month, value: 1, to: start)!
            return (start, end)
        case .quarterly:
            let month = calendar.component(.month, from: date)
            let quarterStart = ((month - 1) / 3) * 3 + 1
            var comps = calendar.dateComponents([.year], from: date)
            comps.month = quarterStart
            comps.day = 1
            let start = calendar.date(from: comps)!
            let end = calendar.date(byAdding: .month, value: 3, to: start)!
            return (start, end)
        case .yearly:
            let start = calendar.date(from: calendar.dateComponents([.year], from: date))!
            let end = calendar.date(byAdding: .year, value: 1, to: start)!
            return (start, end)
        }
    }

    var netAmount: Double { totalIncome - totalExpense }

    var formattedTotalExpense: String { totalExpense.currencyString }
    var formattedTotalIncome: String { totalIncome.currencyString }
    var formattedNet: String { netAmount.currencyString }
}
