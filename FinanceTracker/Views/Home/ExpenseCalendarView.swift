import SwiftUI

struct ExpenseCalendarView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedMonth: Date
    let allExpenses: [Expense]

    private let cal = Calendar.current
    private let weekdaySymbols: [String] = {
        var cal = Calendar.current
        cal.firstWeekday = 1
        return cal.shortWeekdaySymbols
    }()

    private var monthStart: Date {
        cal.date(from: cal.dateComponents([.year, .month], from: selectedMonth))!
    }

    private var monthEnd: Date {
        cal.date(byAdding: .month, value: 1, to: monthStart)!
    }

    private var monthExpenses: [Expense] {
        allExpenses.filter { $0.date >= monthStart && $0.date < monthEnd }
    }

    private var dailySpending: [Int: Double] {
        var result: [Int: Double] = [:]
        for expense in monthExpenses where !expense.isIncome {
            let day = cal.component(.day, from: expense.date)
            result[day, default: 0] += expense.amount
        }
        return result
    }

    private var daysInMonth: Int {
        cal.range(of: .day, in: .month, for: monthStart)!.count
    }

    private var firstWeekday: Int {
        (cal.component(.weekday, from: monthStart) - cal.firstWeekday + 7) % 7
    }

    private var totalCells: Int {
        firstWeekday + daysInMonth
    }

    private var rows: Int {
        (totalCells + 6) / 7
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                DSMonthNavigator(currentDate: $selectedMonth, style: .prominent)
                    .padding(.horizontal, M3Spacing.base)
                    .padding(.top, M3Spacing.sm)
                    .padding(.bottom, M3Spacing.md)

                weekdayHeader

                calendarGrid
                    .padding(.horizontal, M3Spacing.sm)

                Spacer()

                dailySummary
            }
            .background(M3Color.Adaptive.surface)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(M3Typography.titleMedium)
                            .foregroundColor(M3Color.Adaptive.onSurface)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(L("收支日历"))
                        .font(M3Typography.titleMedium)
                        .foregroundColor(M3Color.Adaptive.onSurface)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        selectedMonth = Date()
                    } label: {
                        Text(L("今天"))
                            .font(M3Typography.labelLarge)
                            .foregroundColor(M3Color.Adaptive.primary)
                    }
                }
            }
        }
    }

    // MARK: - Weekday Header

    private var weekdayHeader: some View {
        HStack(spacing: 0) {
            ForEach(weekdaySymbols, id: \.self) { symbol in
                Text(symbol)
                    .font(M3Typography.labelMedium)
                    .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, M3Spacing.sm)
        .padding(.bottom, M3Spacing.sm)
    }

    // MARK: - Calendar Grid

    private var calendarGrid: some View {
        VStack(spacing: M3Spacing.xxs) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: M3Spacing.xxs) {
                    ForEach(0..<7, id: \.self) { col in
                        let cellIndex = row * 7 + col
                        let dayNumber = cellIndex - firstWeekday + 1

                        if dayNumber >= 1 && dayNumber <= daysInMonth {
                            dayCellView(day: dayNumber)
                        } else {
                            Color.clear
                                .frame(maxWidth: .infinity)
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
            }
        }
    }

    private func dayCellView(day: Int) -> some View {
        let isToday = cal.isDateInToday(dateForDay(day))
        let spending = dailySpending[day]

        return VStack(spacing: M3Spacing.xxs) {
            Text("\(day)")
                .font(M3Typography.titleSmall)
                .foregroundColor(isToday ? M3Color.Adaptive.onPrimary : M3Color.Adaptive.onSurface)
                .frame(width: 28, height: 28)
                .background(isToday ? M3Color.Adaptive.primary : Color.clear)
                .clipShape(Circle())

            if let amount = spending {
                Text(shortAmount(amount))
                    .font(.system(size: 9))
                    .foregroundColor(M3Color.Adaptive.error)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
            } else {
                Text(" ")
                    .font(.system(size: 9))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, M3Spacing.xs)
        .background(
            RoundedRectangle(cornerRadius: M3Radius.extraSmall)
                .fill(isToday ? M3Color.Adaptive.primaryContainer.opacity(0.3) : Color.clear)
        )
    }

    // MARK: - Daily Summary

    private var dailySummary: some View {
        let totalSpending = monthExpenses.filter { !$0.isIncome }.reduce(0) { $0 + $1.amount }
        let totalIncome = monthExpenses.filter { $0.isIncome }.reduce(0) { $0 + $1.amount }
        let activeDays = Set(monthExpenses.filter { !$0.isIncome }.map { cal.component(.day, from: $0.date) }).count

        return VStack(spacing: M3Spacing.md) {
            Divider()
            DSStatRow(items: [
                DSStatItem(label: L("总支出"), value: totalSpending.currencyString, color: M3Color.Adaptive.error),
                DSStatItem(label: L("总收入"), value: totalIncome.currencyString, color: M3Color.Adaptive.primary),
                DSStatItem(label: L("记账天数"), value: "\(activeDays)")
            ])
            .padding(.horizontal, M3Spacing.xl)
            .padding(.bottom, M3Spacing.xxl)
        }
    }

    // MARK: - Helpers

    private func dateForDay(_ day: Int) -> Date {
        cal.date(bySetting: .day, value: day, of: monthStart) ?? monthStart
    }

    private func shortAmount(_ value: Double) -> String {
        if value >= 10000 {
            return String(format: "%.1fw", value / 10000)
        } else if value >= 1000 {
            return String(format: "%.0f", value)
        } else {
            return String(format: "%.0f", value)
        }
    }
}
