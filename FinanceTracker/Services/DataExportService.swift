import Foundation
import SwiftData
import UniformTypeIdentifiers

class DataExportService {

    // I5: Use fixed internal keys for CSV so import works across languages
    static func exportToCSV(expenses: [Expense]) -> String {
        var csv = "date,type,category,amount,note,account,source\n"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        for expense in expenses {
            let date = dateFormatter.string(from: expense.date)
            let type = expense.isIncome ? "income" : "expense"
            let category = expense.category?.name ?? ""
            let amount = NSDecimalNumber(decimal: expense.amount).stringValue
            let note = expense.note.replacingOccurrences(of: ",", with: "，")
            let account = expense.account?.name ?? ""
            let source = expense.sourceType.rawValue
            csv += "\(date),\(type),\(category),\(amount),\(note),\(account),\(source)\n"
        }

        return csv
    }

    static func exportToJSON(expenses: [Expense]) throws -> Data {
        struct ExpenseExport: Codable {
            let date: String
            let isIncome: Bool
            let category: String
            let amount: String
            let note: String
            let account: String
            let source: String
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        let exports = expenses.map { expense in
            ExpenseExport(
                date: dateFormatter.string(from: expense.date),
                isIncome: expense.isIncome,
                category: expense.category?.name ?? "",
                amount: NSDecimalNumber(decimal: expense.amount).stringValue,
                note: expense.note,
                account: expense.account?.name ?? "",
                source: expense.sourceType.rawValue
            )
        }

        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return try encoder.encode(exports)
    }

    // I5: Import recognizes both old localized keys and new fixed keys
    static func importFromCSV(_ content: String, modelContext: ModelContext) throws -> Int {
        let lines = content.components(separatedBy: .newlines).filter { !$0.isEmpty }
        guard lines.count > 1 else { return 0 }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        var count = 0
        for line in lines.dropFirst() {
            let fields = line.components(separatedBy: ",")
            guard fields.count >= 4 else { continue }

            let date = dateFormatter.date(from: fields[0]) ?? Date()
            let isIncome = fields[1] == "income" || fields[1] == L("收入")
            let amount = Decimal(string: fields[3]) ?? Decimal.zero
            guard amount > 0 else { continue }

            let expense = Expense(
                amount: amount,
                note: fields.count > 4 ? fields[4] : "",
                date: date,
                isIncome: isIncome,
                sourceType: .fileImport
            )
            modelContext.insert(expense)
            count += 1
        }

        try modelContext.save()
        return count
    }
}
