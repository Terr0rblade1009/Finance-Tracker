import SwiftUI
import SwiftData

struct FixedExpenseView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var fixedExpenses: [FixedExpense]
    @State private var showAdd = false

    private var totalMonthly: Double {
        fixedExpenses.filter(\.isActive).reduce(0) { $0 + $1.monthlyAmount }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: M3Spacing.lg) {
                    DSSummaryCard(
                        title: L("每月固定开支"),
                        amount: totalMonthly.currencyString,
                        secondaryItems: [
                            DSStatItem(label: L("每季度"), value: (totalMonthly * 3).currencyString),
                            DSStatItem(label: L("每年"), value: (totalMonthly * 12).currencyString)
                        ]
                    )
                    expenseList
                }
                .padding(.horizontal, M3Spacing.base)
                .padding(.top, M3Spacing.sm)
            }
            .background(M3Color.Adaptive.surface)
            .navigationTitle(L("固定开支"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAdd = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: M3IconSize.medium))
                            .foregroundColor(M3Color.Adaptive.primary)
                    }
                }
            }
            .sheet(isPresented: $showAdd) {
                AddFixedExpenseSheet()
            }
        }
    }

    private var expenseList: some View {
        VStack(spacing: M3Spacing.sm) {
            ForEach(fixedExpenses) { expense in
                DSTransactionRow(
                    icon: expense.categoryIcon,
                    iconColor: Color(hex: expense.categoryColorHex),
                    title: expense.name,
                    subtitle: "\(L("年付")) \(expense.annualAmount.currencyString)",
                    trailingTop: expense.formattedMonthly,
                    trailingBottom: L("/月")
                )
                .opacity(expense.isActive ? 1 : 0.5)
            }
        }
    }
}

// MARK: - Add Fixed Expense Sheet

struct AddFixedExpenseSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var annualAmount = ""
    @State private var selectedFrequency = FixedExpense.Frequency.annual
    @State private var selectedCategory = ExpenseCategory.fixedExpenseCategories().first!

    private let fixedCategories = ExpenseCategory.fixedExpenseCategories()

    var computedMonthly: Double {
        let annual = Double(annualAmount) ?? 0
        return annual / 12.0
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: M3Spacing.xl) {
                    DSTextField(label: L("名称"), text: $name, icon: "tag.fill")

                    DSTextField(
                        label: L("年度金额 ($)"),
                        text: $annualAmount,
                        icon: "yensign.circle.fill",
                        keyboardType: .decimalPad
                    )

                    if let amount = Double(annualAmount), amount > 0 {
                        DSCard(variant: .outlined) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(L("每月约"))
                                        .font(M3Typography.labelSmall)
                                        .foregroundColor(M3Color.Adaptive.outline)
                                    Text((amount / 12).currencyString)
                                        .font(M3Typography.titleMedium)
                                        .foregroundColor(M3Color.Adaptive.primary)
                                }
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text(L("每季约"))
                                        .font(M3Typography.labelSmall)
                                        .foregroundColor(M3Color.Adaptive.outline)
                                    Text((amount / 4).currencyString)
                                        .font(M3Typography.titleMedium)
                                        .foregroundColor(M3Color.Adaptive.onSurface)
                                }
                            }
                            .padding(M3Spacing.base)
                        }
                    }

                    VStack(alignment: .leading, spacing: M3Spacing.md) {
                        Text(L("分类"))
                            .font(M3Typography.labelLarge)
                            .foregroundColor(M3Color.Adaptive.onSurfaceVariant)

                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: M3Spacing.sm) {
                            ForEach(fixedCategories, id: \.name) { cat in
                                Button {
                                    selectedCategory = cat
                                } label: {
                                    HStack(spacing: M3Spacing.sm) {
                                        Image(systemName: cat.icon)
                                            .font(M3Typography.bodyMedium)
                                        Text(cat.localizedName)
                                            .font(M3Typography.labelMedium)
                                    }
                                    .padding(.horizontal, M3Spacing.md)
                                    .padding(.vertical, M3Spacing.sm)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(
                                        selectedCategory.name == cat.name
                                            ? M3Color.Adaptive.onPrimary
                                            : M3Color.Adaptive.onSurfaceVariant
                                    )
                                    .background(
                                        selectedCategory.name == cat.name
                                            ? M3Color.Adaptive.primary
                                            : M3Color.Adaptive.surfaceContainerHigh
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: M3Radius.small))
                                }
                            }
                        }
                    }

                    DSButton(
                        title: L("保存"),
                        icon: "checkmark",
                        variant: .filled,
                        size: .large,
                        isFullWidth: true,
                        isDisabled: name.isEmpty || annualAmount.isEmpty
                    ) {
                        let expense = FixedExpense(
                            name: name,
                            annualAmount: Double(annualAmount) ?? 0,
                            categoryIcon: selectedCategory.icon,
                            categoryColorHex: selectedCategory.colorHex
                        )
                        modelContext.insert(expense)
                        try? modelContext.save()
                        dismiss()
                    }
                }
                .padding(M3Spacing.xl)
            }
            .background(M3Color.Adaptive.surface)
            .navigationTitle(L("添加固定开支"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(L("取消")) { dismiss() }
                }
            }
        }
    }
}
