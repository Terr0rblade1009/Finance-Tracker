import SwiftUI
import SwiftData

struct CategoryManagementView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ExpenseCategory.sortOrder) private var categories: [ExpenseCategory]
    @State private var selectedTab = 0
    @State private var showAddCategory = false

    private var expenseCategories: [ExpenseCategory] {
        categories.filter { !$0.isIncome && $0.parentCategoryId == nil }
    }

    private var incomeCategories: [ExpenseCategory] {
        categories.filter { $0.isIncome && $0.parentCategoryId == nil }
    }

    private var displayCategories: [ExpenseCategory] {
        selectedTab == 0 ? expenseCategories : incomeCategories
    }

    var body: some View {
        VStack(spacing: 0) {
            DSSegmentedControl(items: [L("支出分类"), L("收入分类")], selectedIndex: $selectedTab)

            ScrollView {
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible(), spacing: M3Spacing.md), count: 4),
                    spacing: M3Spacing.lg
                ) {
                    ForEach(displayCategories) { category in
                        DSCategoryCell(
                            icon: category.icon,
                            name: category.localizedName,
                            color: Color(hex: category.colorHex)
                        )
                        .contextMenu {
                            if !category.isSystem {
                                Button(role: .destructive) {
                                    deleteCategory(category)
                                } label: {
                                    Label(L("删除"), systemImage: "trash")
                                }
                            }
                        }
                    }

                    Button {
                        showAddCategory = true
                    } label: {
                        VStack(spacing: M3Spacing.sm) {
                            ZStack {
                                Circle()
                                    .strokeBorder(M3Color.Adaptive.outline, style: StrokeStyle(lineWidth: 1, dash: [4]))
                                    .frame(width: 48, height: 48)
                                Image(systemName: "plus")
                                    .font(.system(size: 20))
                                    .foregroundColor(M3Color.Adaptive.outline)
                            }
                            Text(L("添加"))
                                .font(M3Typography.labelSmall)
                                .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                        }
                    }
                }
                .padding(M3Spacing.base)
            }
        }
        .background(M3Color.Adaptive.surface)
        .navigationTitle(L("分类管理"))
        .sheet(isPresented: $showAddCategory) {
            AddCategorySheet(isIncome: selectedTab == 1)
        }
    }

    private func deleteCategory(_ category: ExpenseCategory) {
        guard !category.isSystem else { return }
        modelContext.delete(category)
        try? modelContext.save()
    }
}

// MARK: - Add Category Sheet

struct AddCategorySheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let isIncome: Bool

    @State private var name = ""
    @State private var selectedIcon = "tag.fill"
    @State private var selectedColor = "FF8A65"

    private let iconOptions = [
        "tag.fill", "cart.fill", "bag.fill", "cup.and.saucer.fill",
        "car.fill", "airplane", "bus.fill", "tram.fill",
        "house.fill", "building.2.fill", "heart.fill", "cross.case.fill",
        "book.fill", "graduationcap.fill", "music.note", "gamecontroller.fill",
        "gift.fill", "phone.fill", "tv.fill", "desktopcomputer",
        "pawprint.fill", "leaf.fill", "flame.fill", "drop.fill"
    ]

    private let colorOptions = [
        "FF8A65", "4FC3F7", "BA68C8", "FFD54F",
        "81C784", "7986CB", "A1887F", "4DB6AC",
        "9575CD", "F06292", "FFB74D", "64B5F6",
        "AED581", "EF5350", "26C6DA", "78909C"
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: M3Spacing.xl) {
                    VStack(spacing: M3Spacing.sm) {
                        ZStack {
                            Circle()
                                .fill(Color(hex: selectedColor).opacity(0.15))
                                .frame(width: 64, height: 64)
                            Image(systemName: selectedIcon)
                                .font(.system(size: 28))
                                .foregroundColor(Color(hex: selectedColor))
                        }
                        Text(name.isEmpty ? L("分类名称") : name)
                            .font(M3Typography.titleSmall)
                            .foregroundColor(M3Color.Adaptive.onSurface)
                    }
                    .padding(.top, M3Spacing.lg)

                    DSTextField(label: L("分类名称"), text: $name, icon: "pencil")

                    VStack(alignment: .leading, spacing: M3Spacing.md) {
                        Text(L("图标"))
                            .font(M3Typography.labelLarge)
                            .foregroundColor(M3Color.Adaptive.onSurfaceVariant)

                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: M3Spacing.md) {
                            ForEach(iconOptions, id: \.self) { icon in
                                Button {
                                    selectedIcon = icon
                                } label: {
                                    Image(systemName: icon)
                                        .font(.system(size: 20))
                                        .frame(width: 44, height: 44)
                                        .foregroundColor(
                                            selectedIcon == icon
                                                ? M3Color.Adaptive.onPrimary
                                                : M3Color.Adaptive.onSurfaceVariant
                                        )
                                        .background(
                                            selectedIcon == icon
                                                ? M3Color.Adaptive.primary
                                                : M3Color.Adaptive.surfaceContainerHigh
                                        )
                                        .clipShape(RoundedRectangle(cornerRadius: M3Radius.medium))
                                }
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: M3Spacing.md) {
                        Text(L("颜色"))
                            .font(M3Typography.labelLarge)
                            .foregroundColor(M3Color.Adaptive.onSurfaceVariant)

                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 8), spacing: M3Spacing.md) {
                            ForEach(colorOptions, id: \.self) { color in
                                Button {
                                    selectedColor = color
                                } label: {
                                    Circle()
                                        .fill(Color(hex: color))
                                        .frame(width: 36, height: 36)
                                        .overlay(
                                            Circle()
                                                .strokeBorder(Color.white, lineWidth: selectedColor == color ? 3 : 0)
                                        )
                                        .m3Shadow(selectedColor == color ? M3Elevation.level2 : M3Elevation.level0)
                                }
                            }
                        }
                    }

                    DSButton(
                        title: L("保存"),
                        variant: .filled,
                        size: .large,
                        isFullWidth: true,
                        isDisabled: name.isEmpty
                    ) {
                        let category = ExpenseCategory(
                            name: name,
                            icon: selectedIcon,
                            colorHex: selectedColor,
                            isIncome: isIncome,
                            isSystem: false
                        )
                        modelContext.insert(category)
                        try? modelContext.save()
                        dismiss()
                    }
                }
                .padding(M3Spacing.xl)
            }
            .background(M3Color.Adaptive.surface)
            .navigationTitle(L("添加分类"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(L("取消")) { dismiss() }
                }
            }
        }
    }
}
