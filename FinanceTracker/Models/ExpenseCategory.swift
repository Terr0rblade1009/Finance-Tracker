import Foundation
import SwiftData

@Model
final class ExpenseCategory {
    @Attribute(.unique) var id: UUID
    var name: String
    var icon: String
    var colorHex: String
    var isIncome: Bool
    var parentCategoryId: UUID?
    var sortOrder: Int
    var isSystem: Bool

    @Relationship(deleteRule: .nullify) var expenses: [Expense]?

    init(
        name: String,
        icon: String,
        colorHex: String,
        isIncome: Bool = false,
        parentCategoryId: UUID? = nil,
        sortOrder: Int = 0,
        isSystem: Bool = true
    ) {
        self.id = UUID()
        self.name = name
        self.icon = icon
        self.colorHex = colorHex
        self.isIncome = isIncome
        self.parentCategoryId = parentCategoryId
        self.sortOrder = sortOrder
        self.isSystem = isSystem
    }

    var color: String { colorHex }

    var localizedName: String {
        isSystem ? L(name) : name
    }
}

// MARK: - Default Categories

extension ExpenseCategory {
    static func defaultExpenseCategories() -> [ExpenseCategory] {
        [
            ExpenseCategory(name: "餐饮", icon: "fork.knife", colorHex: "FF8A65", sortOrder: 0),
            ExpenseCategory(name: "交通", icon: "car.fill", colorHex: "4FC3F7", sortOrder: 1),
            ExpenseCategory(name: "购物", icon: "bag.fill", colorHex: "BA68C8", sortOrder: 2),
            ExpenseCategory(name: "娱乐", icon: "gamecontroller.fill", colorHex: "FFD54F", sortOrder: 3),
            ExpenseCategory(name: "医疗", icon: "cross.case.fill", colorHex: "81C784", sortOrder: 4),
            ExpenseCategory(name: "教育", icon: "book.fill", colorHex: "7986CB", sortOrder: 5),
            ExpenseCategory(name: "住房", icon: "house.fill", colorHex: "A1887F", sortOrder: 6),
            ExpenseCategory(name: "水电", icon: "bolt.fill", colorHex: "4DB6AC", sortOrder: 7),
            ExpenseCategory(name: "通信", icon: "phone.fill", colorHex: "9575CD", sortOrder: 8),
            ExpenseCategory(name: "服饰", icon: "tshirt.fill", colorHex: "F06292", sortOrder: 9),
            ExpenseCategory(name: "美容", icon: "sparkles", colorHex: "FFB74D", sortOrder: 10),
            ExpenseCategory(name: "社交", icon: "person.2.fill", colorHex: "64B5F6", sortOrder: 11),
            ExpenseCategory(name: "宠物", icon: "pawprint.fill", colorHex: "AED581", sortOrder: 12),
            ExpenseCategory(name: "其他", icon: "ellipsis.circle.fill", colorHex: "BDBDBD", sortOrder: 13),
        ]
    }

    static func defaultIncomeCategories() -> [ExpenseCategory] {
        [
            ExpenseCategory(name: "工资", icon: "banknote.fill", colorHex: "66BB6A", isIncome: true, sortOrder: 0),
            ExpenseCategory(name: "奖金", icon: "gift.fill", colorHex: "FFA726", isIncome: true, sortOrder: 1),
            ExpenseCategory(name: "投资", icon: "chart.line.uptrend.xyaxis", colorHex: "42A5F5", isIncome: true, sortOrder: 2),
            ExpenseCategory(name: "兼职", icon: "briefcase.fill", colorHex: "AB47BC", isIncome: true, sortOrder: 3),
            ExpenseCategory(name: "红包", icon: "giftcard.fill", colorHex: "EF5350", isIncome: true, sortOrder: 4),
            ExpenseCategory(name: "退款", icon: "arrow.uturn.backward.circle.fill", colorHex: "26C6DA", isIncome: true, sortOrder: 5),
            ExpenseCategory(name: "其他收入", icon: "plus.circle.fill", colorHex: "78909C", isIncome: true, sortOrder: 6),
        ]
    }

    static func fixedExpenseCategories() -> [ExpenseCategory] {
        [
            ExpenseCategory(name: "房贷", icon: "building.2.fill", colorHex: "8D6E63", sortOrder: 0),
            ExpenseCategory(name: "房租", icon: "house.lodge.fill", colorHex: "A1887F", sortOrder: 1),
            ExpenseCategory(name: "车贷", icon: "car.fill", colorHex: "78909C", sortOrder: 2),
            ExpenseCategory(name: "保险", icon: "shield.checkered", colorHex: "90A4AE", sortOrder: 3),
            ExpenseCategory(name: "学费", icon: "graduationcap.fill", colorHex: "7986CB", sortOrder: 4),
            ExpenseCategory(name: "水电费", icon: "drop.fill", colorHex: "4DB6AC", sortOrder: 5),
            ExpenseCategory(name: "网费", icon: "wifi", colorHex: "64B5F6", sortOrder: 6),
            ExpenseCategory(name: "手机费", icon: "iphone", colorHex: "9575CD", sortOrder: 7),
            ExpenseCategory(name: "会员", icon: "star.fill", colorHex: "FFD54F", sortOrder: 8),
        ]
    }
}
