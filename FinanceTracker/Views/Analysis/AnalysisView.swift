import SwiftUI
import SwiftData
import Charts

struct AnalysisView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = AnalysisViewModel()
    @State private var selectedView: AnalysisViewType = .overview
    @State private var periodIndex = 0

    enum AnalysisViewType: String, CaseIterable {
        case overview = "总览"
        case category = "分类"
        case trend = "趋势"

        var displayName: String {
            switch self {
            case .overview: return L("总览")
            case .category: return L("分类")
            case .trend: return L("趋势")
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                DSSegmentedControl(
                    items: AnalysisPeriod.allCases.map(\.displayName),
                    selectedIndex: $periodIndex
                )
                .onChange(of: periodIndex) { _, newValue in
                    viewModel.period = AnalysisPeriod.allCases[newValue]
                    loadData()
                }

                viewTypeSelector

                ScrollView {
                    VStack(spacing: M3Spacing.lg) {
                        switch selectedView {
                        case .overview: overviewSection
                        case .category: categorySection
                        case .trend: trendSection
                        }
                    }
                    .padding(.horizontal, M3Spacing.base)
                    .padding(.top, M3Spacing.md)
                    .padding(.bottom, M3Spacing.huge)
                }
            }
            .background(M3Color.Adaptive.surface)
            .navigationTitle(L("分析"))
            .onAppear { loadData() }
        }
    }

    // MARK: - View Type Selector

    private var viewTypeSelector: some View {
        HStack(spacing: M3Spacing.sm) {
            ForEach(AnalysisViewType.allCases, id: \.self) { type in
                DSChip(
                    label: type.displayName,
                    isSelected: selectedView == type
                ) {
                    withAnimation { selectedView = type }
                }
            }
            Spacer()
        }
        .padding(.horizontal, M3Spacing.base)
        .padding(.bottom, M3Spacing.sm)
    }

    // MARK: - Overview

    private var overviewSection: some View {
        VStack(spacing: M3Spacing.lg) {
            summaryCards

            if !viewModel.categoryBreakdown.isEmpty {
                DSPieChartCard(
                    title: L("支出构成"),
                    data: viewModel.categoryBreakdown.map { item in
                        DSPieChartItem(
                            name: item.categoryName,
                            amount: item.amount,
                            colorHex: item.categoryColorHex,
                            percentage: item.percentage
                        )
                    }
                )
            }
        }
    }

    private var summaryCards: some View {
        VStack(spacing: M3Spacing.md) {
            HStack(spacing: M3Spacing.md) {
                SummaryCard(
                    title: L("总支出"),
                    amount: viewModel.formattedTotalExpense,
                    icon: "arrow.up.circle.fill",
                    color: M3Color.Adaptive.error
                )
                SummaryCard(
                    title: L("总收入"),
                    amount: viewModel.formattedTotalIncome,
                    icon: "arrow.down.circle.fill",
                    color: M3Color.Adaptive.primary
                )
            }

            SummaryCard(
                title: L("净收支"),
                amount: viewModel.formattedNet,
                icon: viewModel.netAmount >= 0 ? "chart.line.uptrend.xyaxis" : "chart.line.downtrend.xyaxis",
                color: viewModel.netAmount >= 0 ? M3Color.Adaptive.primary : M3Color.Adaptive.error
            )
        }
    }

    // MARK: - Category Section

    private var categorySection: some View {
        VStack(spacing: M3Spacing.md) {
            ForEach(viewModel.categoryBreakdown) { item in
                DSCategoryProgressRow(
                    icon: item.categoryIcon,
                    name: item.categoryName,
                    count: item.count,
                    amount: item.amount.currencyString,
                    percentage: item.percentage,
                    color: Color(hex: item.categoryColorHex)
                )
            }
        }
    }

    // MARK: - Trend Section

    private var trendSection: some View {
        VStack(spacing: M3Spacing.lg) {
            DSCard(variant: .filled) {
                VStack(alignment: .leading, spacing: M3Spacing.md) {
                    Text(L("收支趋势"))
                        .font(M3Typography.titleMedium)
                        .foregroundColor(M3Color.Adaptive.onSurface)

                    if !viewModel.dailyTrend.isEmpty {
                        Chart {
                            ForEach(viewModel.dailyTrend) { day in
                                BarMark(
                                    x: .value(L("日期"), day.date, unit: .day),
                                    y: .value(L("支出"), day.expense)
                                )
                                .foregroundStyle(M3Color.Adaptive.error.opacity(0.7))
                                .cornerRadius(M3Radius.extraSmall)

                                if day.income > 0 {
                                    BarMark(
                                        x: .value(L("日期"), day.date, unit: .day),
                                        y: .value(L("收入"), day.income)
                                    )
                                    .foregroundStyle(M3Color.Adaptive.primary.opacity(0.7))
                                    .cornerRadius(M3Radius.extraSmall)
                                }
                            }
                        }
                        .chartXAxis {
                            AxisMarks(values: .stride(by: .day, count: 5)) { _ in
                                AxisGridLine()
                                AxisValueLabel(format: .dateTime.day())
                            }
                        }
                        .frame(height: 220)
                    } else {
                        DSEmptyState(icon: "chart.bar", title: L("暂无数据"))
                    }
                }
                .padding(M3Spacing.base)
            }

            transactionList
        }
    }

    private var transactionList: some View {
        DSTransactionListSection(title: L("交易明细")) {
            ForEach(viewModel.expenses.prefix(50)) { expense in
                ExpenseRow(expense: expense)
            }
        }
    }

    private func loadData() {
        try? viewModel.loadData(modelContext: modelContext)
    }
}

// MARK: - Summary Card

struct SummaryCard: View {
    let title: String
    let amount: String
    let icon: String
    let color: Color

    var body: some View {
        DSCard(variant: .outlined) {
            VStack(alignment: .leading, spacing: M3Spacing.sm) {
                HStack(spacing: M3Spacing.sm) {
                    Image(systemName: icon)
                        .font(.system(size: M3IconSize.medium))
                        .foregroundColor(color)
                    Text(title)
                        .font(M3Typography.labelMedium)
                        .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                }
                Text(amount)
                    .font(M3Typography.titleLarge)
                    .foregroundColor(M3Color.Adaptive.onSurface)
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)
            }
            .padding(M3Spacing.base)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

