import SwiftUI
import SwiftData
import Charts

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Expense.date, order: .reverse) private var allExpenses: [Expense]
    @State private var showCalendar = false
    @State private var selectedMonth = Date()
    @State private var showSearch = false
    @State private var searchText = ""

    private var calendar: Calendar { Calendar.current }

    private var monthStart: Date {
        calendar.date(from: calendar.dateComponents([.year, .month], from: selectedMonth))!
    }

    private var monthEnd: Date {
        calendar.date(byAdding: .month, value: 1, to: monthStart)!
    }

    private var monthExpenses: [Expense] {
        allExpenses.filter { $0.date >= monthStart && $0.date < monthEnd }
    }

    private var monthlySpending: Double {
        monthExpenses.filter { !$0.isIncome }.reduce(0) { $0 + $1.amount }
    }

    private var monthlyIncome: Double {
        monthExpenses.filter { $0.isIncome }.reduce(0) { $0 + $1.amount }
    }

    private var monthBalance: Double {
        monthlyIncome - monthlySpending
    }

    private var categoryBreakdown: [DSPieChartItem] {
        let expenses = monthExpenses.filter { !$0.isIncome }
        var grouping: [String: (icon: String, colorHex: String, amount: Double)] = [:]

        for expense in expenses {
            let name = expense.category?.localizedName ?? L("未分类")
            let icon = expense.category?.icon ?? "ellipsis.circle.fill"
            let colorHex = expense.category?.colorHex ?? "BDBDBD"
            let existing = grouping[name] ?? (icon: icon, colorHex: colorHex, amount: 0)
            grouping[name] = (icon: icon, colorHex: colorHex, amount: existing.amount + expense.amount)
        }

        let total = max(monthlySpending, 1)
        return grouping.map { (name, data) in
            DSPieChartItem(
                name: name,
                amount: data.amount,
                colorHex: data.colorHex,
                percentage: (data.amount / total) * 100
            )
        }
        .sorted { $0.amount > $1.amount }
    }

    private var filteredExpenses: [Expense] {
        guard !searchText.isEmpty else { return monthExpenses }
        let query = searchText.lowercased()
        return monthExpenses.filter { expense in
            (expense.category?.localizedName ?? "").lowercased().contains(query)
            || expense.note.lowercased().contains(query)
            || expense.formattedAmount.contains(query)
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: M3Spacing.lg) {
                    if showSearch {
                        DSSearchBar(text: $searchText, placeholder: L("搜索分类、备注、金额…"))
                            .transition(.move(edge: .top).combined(with: .opacity))
                    }

                    DSMonthNavigator(currentDate: $selectedMonth, style: .compact) {
                        Button {
                            showCalendar = true
                        } label: {
                            HStack(spacing: M3Spacing.xs) {
                                Image(systemName: "calendar")
                                    .font(.system(size: 14))
                                Text(L("收支日历"))
                                    .font(M3Typography.labelMedium)
                            }
                            .foregroundColor(M3Color.Adaptive.primary)
                            .padding(.horizontal, M3Spacing.md)
                            .padding(.vertical, M3Spacing.sm)
                            .background(M3Color.Adaptive.primaryContainer.opacity(0.4))
                            .clipShape(RoundedRectangle(cornerRadius: M3Radius.full))
                        }
                    }

                    if !showSearch {
                        DSSummaryCard(
                            title: L("总支出"),
                            amount: monthlySpending.currencyString,
                            titleDotColor: M3Color.Light.error,
                            secondaryItems: [
                                DSStatItem(label: L("总收入"), value: monthlyIncome.currencyString),
                                DSStatItem(
                                    label: L("月结余"),
                                    value: monthBalance.currencyString,
                                    color: monthBalance >= 0 ? M3Color.Light.primary : M3Color.Light.error
                                )
                            ]
                        )

                        if !categoryBreakdown.isEmpty {
                            DSPieChartCard(title: L("支出构成"), data: categoryBreakdown)
                        }
                    }

                    transactionListSection
                }
                .padding(.horizontal, M3Spacing.base)
                .padding(.top, M3Spacing.sm)
                .padding(.bottom, M3Spacing.huge)
            }
            .background(M3Color.Adaptive.surface)
            .navigationTitle(L("记账本"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: M3Spacing.xs) {
                        Button {
                            withAnimation(.spring(response: 0.3)) {
                                showSearch.toggle()
                                if !showSearch { searchText = "" }
                            }
                        } label: {
                            Image(systemName: showSearch ? "xmark" : "magnifyingglass")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                                .frame(width: 36, height: 36)
                                .background(M3Color.Adaptive.surfaceContainerHigh)
                                .clipShape(Circle())
                        }

                        NavigationLink {
                            ExpenseCalendarView(selectedMonth: $selectedMonth, allExpenses: allExpenses)
                        } label: {
                            Image(systemName: "calendar")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                                .frame(width: 36, height: 36)
                                .background(M3Color.Adaptive.surfaceContainerHigh)
                                .clipShape(Circle())
                        }
                    }
                }
            }
            .sheet(isPresented: $showCalendar) {
                ExpenseCalendarView(selectedMonth: $selectedMonth, allExpenses: allExpenses)
            }
        }
    }

    // MARK: - Transaction List

    private var transactionListSection: some View {
        DSTransactionListSection(title: showSearch ? L("搜索结果") : L("本月明细")) {
            if filteredExpenses.isEmpty {
                DSEmptyState(
                    icon: showSearch ? "magnifyingglass" : "tray",
                    title: showSearch ? L("没有匹配的记录") : L("本月暂无数据"),
                    subtitle: showSearch ? nil : L("点击底部 + 开始记账")
                )
            } else {
                ForEach(filteredExpenses) { expense in
                    ExpenseRow(expense: expense)
                }
            }
        }
    }
}

// MARK: - Expense Row

struct ExpenseRow: View {
    let expense: Expense

    var body: some View {
        DSTransactionRow(
            icon: expense.category?.icon ?? "ellipsis.circle.fill",
            iconColor: Color(hex: expense.category?.colorHex ?? "BDBDBD"),
            title: expense.category?.localizedName ?? L("未分类"),
            subtitle: expense.note.isEmpty ? nil : expense.note,
            trailingTop: "\(expense.isIncome ? "+" : "-")\(expense.formattedAmount)",
            trailingBottom: expense.formattedDate,
            trailingTopColor: expense.isIncome ? M3Color.Light.primary : M3Color.Adaptive.onSurface
        )
    }
}
