import Foundation
import SwiftData
import UniformTypeIdentifiers

class DataExportService {

    static func exportToCSV(expenses: [Expense]) -> String {
        var csv = L("日期,类型,分类,金额,备注,账户,来源") + "\n"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        for expense in expenses {
            let date = dateFormatter.string(from: expense.date)
            let type = expense.isIncome ? L("收入") : L("支出")
            let category = expense.category?.localizedName ?? L("未分类")
            let amount = String(format: "%.2f", expense.amount)
            let note = expense.note.replacingOccurrences(of: ",", with: "，")
            let account = expense.account?.localizedName ?? ""
            let source = Expense.SourceType(rawValue: expense.sourceType)?.displayName ?? expense.sourceType
            csv += "\(date),\(type),\(category),\(amount),\(note),\(account),\(source)\n"
        }

        return csv
    }

    static func exportToJSON(expenses: [Expense]) throws -> Data {
        struct ExpenseExport: Codable {
            let date: String
            let isIncome: Bool
            let category: String
            let amount: Double
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
                category: expense.category?.localizedName ?? "",
                amount: expense.amount,
                note: expense.note,
                account: expense.account?.localizedName ?? "",
                source: expense.sourceType
            )
        }

        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return try encoder.encode(exports)
    }

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
            let isIncome = fields[1] == L("收入")
            let amount = Double(fields[3]) ?? 0

            let expense = Expense(
                amount: amount,
                note: fields.count > 4 ? fields[4] : "",
                date: date,
                isIncome: isIncome,
                sourceType: "file_import"
            )
            modelContext.insert(expense)
            count += 1
        }

        try modelContext.save()
        return count
    }
}
