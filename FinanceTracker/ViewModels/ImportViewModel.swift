import Foundation
import SwiftUI
import SwiftData

@Observable
class ImportViewModel {
    var isProcessing = false
    var recognizedText = ""
    var recognizedAmount: Double?
    var errorMessage: String?
    var importedExpenses: [ParsedExpense] = []

    struct ParsedExpense: Identifiable {
        let id = UUID()
        var amount: Double
        var note: String
        var date: Date
        var isSelected: Bool = true
    }

    func parseRecognizedText() {
        let lines = recognizedText.components(separatedBy: .newlines)
        var parsed: [ParsedExpense] = []

        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            if let amount = extractAmount(from: trimmed) {
                parsed.append(ParsedExpense(
                    amount: amount,
                    note: extractNote(from: trimmed),
                    date: Date()
                ))
            }
        }

        importedExpenses = parsed
    }

    func parseWeChatText(_ text: String) {
        recognizedText = text
        let lines = text.components(separatedBy: .newlines)
        var parsed: [ParsedExpense] = []

        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            if let amount = extractAmount(from: trimmed) {
                parsed.append(ParsedExpense(
                    amount: abs(amount),
                    note: extractNote(from: trimmed),
                    date: Date()
                ))
            }
        }

        importedExpenses = parsed
    }

    func saveImportedExpenses(
        modelContext: ModelContext,
        category: ExpenseCategory?,
        account: Account?,
        sourceType: Expense.SourceType
    ) throws {
        let selected = importedExpenses.filter { $0.isSelected }
        for item in selected {
            let expense = Expense(
                amount: item.amount,
                note: item.note,
                date: item.date,
                category: category,
                account: account,
                sourceType: sourceType.rawValue
            )
            modelContext.insert(expense)
        }
        try modelContext.save()
        importedExpenses = []
    }

    private func extractAmount(from text: String) -> Double? {
        let pattern = #"[¥￥$]?\s*(\d+[.,]?\d{0,2})"#
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)),
              let range = Range(match.range(at: 1), in: text) else {
            return nil
        }
        let numberStr = String(text[range]).replacingOccurrences(of: ",", with: "")
        return Double(numberStr)
    }

    private func extractNote(from text: String) -> String {
        let cleaned = text.replacingOccurrences(
            of: #"[¥￥$]?\s*\d+[.,]?\d{0,2}"#,
            with: "",
            options: .regularExpression
        )
        return cleaned.trimmingCharacters(in: .whitespaces)
    }

    func reset() {
        recognizedText = ""
        recognizedAmount = nil
        errorMessage = nil
        importedExpenses = []
        isProcessing = false
    }
}
