import SwiftUI
import SwiftData

struct ExpenseInputView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query(filter: #Predicate<ExpenseCategory> { !$0.isIncome }) private var expenseCategories: [ExpenseCategory]
    @Query(filter: #Predicate<ExpenseCategory> { $0.isIncome }) private var incomeCategories: [ExpenseCategory]
    @Query private var accounts: [Account]

    @State private var viewModel = ExpenseViewModel()
    @State private var selectedTab = 0
    @State private var showDatePicker = false
    @State private var showSuccess = false

    private var categories: [ExpenseCategory] {
        selectedTab == 0 ? expenseCategories : incomeCategories
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                DSSegmentedControl(items: [L("支出"), L("收入")], selectedIndex: $selectedTab)
                    .onChange(of: selectedTab) { _, newValue in
                        viewModel.isIncome = newValue == 1
                    }

                ScrollView {
                    VStack(spacing: M3Spacing.lg) {
                        amountDisplay
                        categoryGrid
                        accountSelector
                        noteField
                        dateSelector
                    }
                    .padding(.horizontal, M3Spacing.base)
                    .padding(.bottom, 300)
                }

                DSNumericKeypad(value: $viewModel.amount) {
                    saveExpense()
                }
                .background(M3Color.Adaptive.surfaceContainerLow)
            }
            .background(M3Color.Adaptive.surface)
            .navigationTitle(selectedTab == 0 ? L("支出") : L("收入"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(L("取消")) { dismiss() }
                        .foregroundColor(M3Color.Adaptive.primary)
                }
            }
            .overlay {
                if showSuccess {
                    successOverlay
                }
            }
        }
    }

    // MARK: - Amount Display

    private var amountDisplay: some View {
        DSAmountDisplay(
            label: selectedTab == 0 ? L("支出金额") : L("收入金额"),
            amount: viewModel.amount
        )
    }

    // MARK: - Category Grid

    private var categoryGrid: some View {
        DSCategoryGridSection(
            title: L("分类"),
            categories: categories.map { cat in
                DSCategoryGridSection.CategoryItem(
                    id: cat.id,
                    icon: cat.icon,
                    name: cat.localizedName,
                    color: Color(hex: cat.colorHex)
                )
            },
            selectedId: viewModel.selectedCategory?.id
        ) { id in
            viewModel.selectedCategory = categories.first { $0.id == id }
        }
    }

    // MARK: - Account Selector

    private var accountSelector: some View {
        DSChipRowSection(
            title: L("账户"),
            chips: accounts.map { account in
                DSChipRowSection.ChipItem(
                    id: account.id,
                    label: account.localizedName,
                    icon: account.icon,
                    color: Color(hex: account.colorHex)
                )
            },
            selectedId: viewModel.selectedAccount?.id
        ) { id in
            viewModel.selectedAccount = accounts.first { $0.id == id }
        }
    }

    // MARK: - Note Field

    private var noteField: some View {
        HStack(spacing: M3Spacing.md) {
            Image(systemName: "pencil")
                .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
            TextField(L("添加备注..."), text: $viewModel.note)
                .font(M3Typography.bodyMedium)
        }
        .padding(M3Spacing.md)
        .background(M3Color.Adaptive.surfaceContainerHigh)
        .clipShape(RoundedRectangle(cornerRadius: M3Radius.medium))
    }

    // MARK: - Date Selector

    private var dateSelector: some View {
        Button {
            showDatePicker.toggle()
        } label: {
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                Text(viewModel.date.formatted(.dateTime.month().day().hour().minute()))
                    .font(M3Typography.bodyMedium)
                    .foregroundColor(M3Color.Adaptive.onSurface)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(M3Color.Adaptive.outline)
            }
            .padding(M3Spacing.md)
            .background(M3Color.Adaptive.surfaceContainerHigh)
            .clipShape(RoundedRectangle(cornerRadius: M3Radius.medium))
        }
        .sheet(isPresented: $showDatePicker) {
            DatePicker(L("选择日期"), selection: $viewModel.date)
                .datePickerStyle(.graphical)
                .padding()
                .presentationDetents([.medium])
        }
    }

    // MARK: - Success Overlay

    private var successOverlay: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()

            VStack(spacing: M3Spacing.base) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 56))
                    .foregroundColor(M3Color.Adaptive.primary)
                Text(L("记录成功"))
                    .font(M3Typography.titleMedium)
                    .foregroundColor(.white)
            }
            .transition(.scale.combined(with: .opacity))
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation { showSuccess = false }
                dismiss()
            }
        }
    }

    private func saveExpense() {
        do {
            try viewModel.saveExpense(modelContext: modelContext)
            withAnimation(.spring) { showSuccess = true }
        } catch {
            // Handle error
        }
    }
}
