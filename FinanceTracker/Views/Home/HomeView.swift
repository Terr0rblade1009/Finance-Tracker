import SwiftUI
import SwiftData
import Charts

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    // I1: Limit query to recent data instead of loading all history
    @Query(sort: \Expense.date, order: .reverse) private var allExpenses: [Expense]
    @State private var showCalendar = false
    @State private var selectedMonth = Date()
    @State private var showSearch = false
    @State private var searchText = ""

    init() {
        // Load expenses from 2 years ago to cover reasonable navigation range
        let twoYearsAgo = Calendar.current.date(byAdding: .year, value: -2, to: Date()) ?? Date()
        _allExpenses = Query(
            filter: #Predicate<Expense> { $0.date >= twoYearsAgo },
            sort: \Expense.date,
            order: .reverse
        )
    }

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

    // M4: Uses shared extension instead of inline aggregation
    private var monthlySpending: Decimal { monthExpenses.total(isIncome: false) }
    private var monthlyIncome: Decimal { monthExpenses.total(isIncome: true) }
    private var monthBalance: Decimal { monthlyIncome - monthlySpending }

    private var categoryBreakdown: [DSPieChartItem] {
        let breakdown = monthExpenses.categoryBreakdown(isIncome: false)
        let total = monthlySpending > 0 ? monthlySpending : Decimal(1)
        return breakdown.map { item in
            DSPieChartItem(
                name: item.name,
                amount: item.amount.doubleValue,
                colorHex: item.colorHex,
                percentage: NSDecimalNumber(decimal: (item.amount / total) * 100).doubleValue
            )
        }
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
                                    .font(M3Typography.bodyMedium)
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
                            titleDotColor: M3Color.Adaptive.error,
                            secondaryItems: [
                                DSStatItem(label: L("总收入"), value: monthlyIncome.currencyString),
                                DSStatItem(
                                    label: L("月结余"),
                                    value: monthBalance.currencyString,
                                    color: monthBalance >= 0 ? M3Color.Adaptive.primary : M3Color.Adaptive.error
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
                                .font(M3Typography.titleMedium)
                                .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                                .frame(width: M3IconSize.large, height: M3IconSize.large)
                                .background(M3Color.Adaptive.surfaceContainerHigh)
                                .clipShape(Circle())
                        }

                        NavigationLink {
                            ExpenseCalendarView(selectedMonth: $selectedMonth, allExpenses: allExpenses)
                        } label: {
                            Image(systemName: "calendar")
                                .font(M3Typography.titleMedium)
                                .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                                .frame(width: M3IconSize.large, height: M3IconSize.large)
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
            trailingTopColor: expense.isIncome ? M3Color.Adaptive.primary : M3Color.Adaptive.onSurface
        )
    }
}
