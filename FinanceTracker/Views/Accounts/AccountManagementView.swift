import SwiftUI
import SwiftData

struct AccountManagementView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Account.sortOrder) private var accounts: [Account]
    @State private var showAddAccount = false
    @State private var showTransfer = false

    private var totalBalance: Double {
        accounts.reduce(0) { $0 + $1.balance }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: M3Spacing.lg) {
                DSSummaryCard(
                    title: L("总资产"),
                    amount: totalBalance.currencyString
                )

                HStack(spacing: M3Spacing.md) {
                    DSButton(title: L("转账"), icon: "arrow.left.arrow.right", variant: .tonal, size: .medium) {
                        showTransfer = true
                    }
                    DSButton(title: L("添加账户"), icon: "plus", variant: .outlined, size: .medium) {
                        showAddAccount = true
                    }
                }

                accountsList
            }
            .padding(M3Spacing.base)
        }
        .background(M3Color.Adaptive.surface)
        .navigationTitle(L("账户管理"))
        .sheet(isPresented: $showAddAccount) {
            AddAccountSheet()
        }
        .sheet(isPresented: $showTransfer) {
            TransferSheet()
        }
    }

    private var accountsList: some View {
        VStack(spacing: M3Spacing.sm) {
            ForEach(accounts) { account in
                DSTransactionRow(
                    icon: account.icon,
                    iconColor: Color(hex: account.colorHex),
                    title: account.localizedName,
                    subtitle: Account.AccountType(rawValue: account.accountType)?.displayName ?? account.accountType,
                    trailingTop: account.balance.currencyString,
                    trailingTopColor: account.balance >= 0 ? M3Color.Adaptive.onSurface : M3Color.Adaptive.error
                )
            }
        }
    }
}

// MARK: - Add Account

struct AddAccountSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var balance = ""
    @State private var selectedType = Account.AccountType.bankCard

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: M3Spacing.xl) {
                    DSTextField(label: L("账户名称"), text: $name, icon: "wallet.pass.fill")
                    DSTextField(label: L("初始余额"), text: $balance, icon: "yensign.circle", keyboardType: .decimalPad)

                    VStack(alignment: .leading, spacing: M3Spacing.md) {
                        Text(L("账户类型"))
                            .font(M3Typography.labelLarge)
                            .foregroundColor(M3Color.Adaptive.onSurfaceVariant)

                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: M3Spacing.sm) {
                            ForEach(Account.AccountType.allCases, id: \.self) { type in
                                Button {
                                    selectedType = type
                                } label: {
                                    HStack(spacing: M3Spacing.sm) {
                                        Image(systemName: type.icon)
                                            .font(.system(size: 16))
                                        Text(type.displayName)
                                            .font(M3Typography.labelMedium)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, M3Spacing.md)
                                    .foregroundColor(
                                        selectedType == type
                                            ? M3Color.Adaptive.onPrimary
                                            : M3Color.Adaptive.onSurfaceVariant
                                    )
                                    .background(
                                        selectedType == type
                                            ? M3Color.Adaptive.primary
                                            : M3Color.Adaptive.surfaceContainerHigh
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: M3Radius.small))
                                }
                            }
                        }
                    }

                    DSButton(
                        title: L("添加账户"),
                        variant: .filled,
                        size: .large,
                        isFullWidth: true,
                        isDisabled: name.isEmpty
                    ) {
                        let account = Account(
                            name: name,
                            icon: selectedType.icon,
                            colorHex: selectedType.colorHex,
                            balance: Double(balance) ?? 0,
                            accountType: selectedType.rawValue
                        )
                        modelContext.insert(account)
                        try? modelContext.save()
                        dismiss()
                    }
                }
                .padding(M3Spacing.xl)
            }
            .background(M3Color.Adaptive.surface)
            .navigationTitle(L("添加账户"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(L("取消")) { dismiss() }
                }
            }
        }
    }
}

// MARK: - Transfer Sheet

struct TransferSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var accounts: [Account]
    @State private var fromAccount: Account?
    @State private var toAccount: Account?
    @State private var amount = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: M3Spacing.xl) {
                DSChipRowSection(
                    title: L("转出账户"),
                    chips: accounts.map { account in
                        DSChipRowSection.ChipItem(
                            id: account.id,
                            label: account.localizedName,
                            icon: account.icon,
                            color: Color(hex: account.colorHex)
                        )
                    },
                    selectedId: fromAccount?.id
                ) { id in
                    fromAccount = accounts.first { $0.id == id }
                }

                Image(systemName: "arrow.down.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(M3Color.Adaptive.primary)

                DSChipRowSection(
                    title: L("转入账户"),
                    chips: accounts.filter { $0.id != fromAccount?.id }.map { account in
                        DSChipRowSection.ChipItem(
                            id: account.id,
                            label: account.localizedName,
                            icon: account.icon,
                            color: Color(hex: account.colorHex)
                        )
                    },
                    selectedId: toAccount?.id
                ) { id in
                    toAccount = accounts.first { $0.id == id }
                }

                DSTextField(label: L("转账金额"), text: $amount, icon: "yensign.circle", keyboardType: .decimalPad)

                Spacer()

                DSButton(
                    title: L("确认转账"),
                    icon: "arrow.left.arrow.right",
                    variant: .filled,
                    size: .large,
                    isFullWidth: true,
                    isDisabled: fromAccount == nil || toAccount == nil || amount.isEmpty
                ) {
                    performTransfer()
                }
            }
            .padding(M3Spacing.xl)
            .background(M3Color.Adaptive.surface)
            .navigationTitle(L("账户转账"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(L("取消")) { dismiss() }
                }
            }
        }
    }

    private func performTransfer() {
        guard let from = fromAccount, let to = toAccount, let transferAmount = Double(amount) else { return }
        from.balance -= transferAmount
        to.balance += transferAmount
        try? modelContext.save()
        dismiss()
    }
}
