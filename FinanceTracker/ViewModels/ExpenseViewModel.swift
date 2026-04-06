import Foundation
import SwiftUI
import SwiftData

@Observable
class ExpenseViewModel {
    var expenses: [Expense] = []
    var selectedCategory: ExpenseCategory?
    var selectedAccount: Account?
    var amount: String = "0"
    var note: String = ""
    var date: Date = Date()
    var isIncome: Bool = false
    var receiptImageData: Data?
    var sourceType: Expense.SourceType = .manual

    var amountValue: Double {
        Double(amount) ?? 0
    }

    func saveExpense(modelContext: ModelContext) throws {
        guard amountValue > 0 else { return }

        let expense = Expense(
            amount: amountValue,
            note: note,
            date: date,
            isIncome: isIncome,
            category: selectedCategory,
            account: selectedAccount,
            receiptImageData: receiptImageData,
            sourceType: sourceType.rawValue
        )

        if let account = selectedAccount {
            if isIncome {
                account.balance += amountValue
            } else {
                account.balance -= amountValue
            }
        }

        modelContext.insert(expense)
        try modelContext.save()
        resetForm()
    }

    func deleteExpense(_ expense: Expense, modelContext: ModelContext) throws {
        if let account = expense.account {
            if expense.isIncome {
                account.balance -= expense.amount
            } else {
                account.balance += expense.amount
            }
        }
        modelContext.delete(expense)
        try modelContext.save()
    }

    func resetForm() {
        amount = "0"
        note = ""
        date = Date()
        selectedCategory = nil
        selectedAccount = nil
        receiptImageData = nil
        sourceType = .manual
    }

    func fetchExpenses(modelContext: ModelContext, for period: AnalysisPeriod = .monthly) throws -> [Expense] {
        let calendar = Calendar.current
        let now = Date()
        var startDate: Date

        switch period {
        case .monthly:
            startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
        case .quarterly:
            let month = calendar.component(.month, from: now)
            let quarterStart = ((month - 1) / 3) * 3 + 1
            var components = calendar.dateComponents([.year], from: now)
            components.month = quarterStart
            components.day = 1
            startDate = calendar.date(from: components)!
        case .yearly:
            startDate = calendar.date(from: calendar.dateComponents([.year], from: now))!
        }

        let descriptor = FetchDescriptor<Expense>(
            predicate: #Predicate { $0.date >= startDate },
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )

        return try modelContext.fetch(descriptor)
    }
}

enum AnalysisPeriod: String, CaseIterable {
    case monthly = "月"
    case quarterly = "季"
    case yearly = "年"

    var displayName: String {
        switch self {
        case .monthly: return L("月")
        case .quarterly: return L("季")
        case .yearly: return L("年")
        }
    }
}
