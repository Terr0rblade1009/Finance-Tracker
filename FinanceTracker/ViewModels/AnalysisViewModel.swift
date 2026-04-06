import Foundation
import SwiftData

@Observable
class AnalysisViewModel {
    var period: AnalysisPeriod = .monthly
    var expenses: [Expense] = []
    var totalExpense: Decimal = 0
    var totalIncome: Decimal = 0
    var categoryBreakdown: [CategorySummary] = []
    var dailyTrend: [DailyAmount] = []

    struct CategorySummary: Identifiable {
        let id = UUID()
        let categoryName: String
        let categoryIcon: String
        let categoryColorHex: String
        let amount: Decimal
        let percentage: Double
        let count: Int
    }

    struct DailyAmount: Identifiable {
        let id = UUID()
        let date: Date
        let expense: Decimal
        let income: Decimal
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

        // M4: Use shared extension
        totalExpense = expenses.total(isIncome: false)
        totalIncome = expenses.total(isIncome: true)

        buildCategoryBreakdown()
        buildDailyTrend(calendar: calendar, startDate: startDate, endDate: endDate)
    }

    // M4: Uses shared categoryBreakdown extension
    private func buildCategoryBreakdown() {
        let breakdown = expenses.categoryBreakdown(isIncome: false)
        let total = totalExpense > 0 ? totalExpense : Decimal(1)

        categoryBreakdown = breakdown.map { item in
            CategorySummary(
                categoryName: item.name,
                categoryIcon: item.icon,
                categoryColorHex: item.colorHex,
                amount: item.amount,
                percentage: NSDecimalNumber(decimal: (item.amount / total) * 100).doubleValue,
                count: item.count
            )
        }
    }

    private func buildDailyTrend(calendar: Calendar, startDate: Date, endDate: Date) {
        var current = startDate
        var trend: [DailyAmount] = []

        while current < endDate {
            let dayEnd = calendar.date(byAdding: .day, value: 1, to: current)!
            let dayExpenses = expenses.filter { $0.date >= current && $0.date < dayEnd }

            let dayExpense = dayExpenses.total(isIncome: false)
            let dayIncome = dayExpenses.total(isIncome: true)

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

    var netAmount: Decimal { totalIncome - totalExpense }

    var formattedTotalExpense: String { totalExpense.currencyString }
    var formattedTotalIncome: String { totalIncome.currencyString }
    var formattedNet: String { netAmount.currencyString }
}
