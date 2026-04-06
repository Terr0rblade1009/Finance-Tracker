import SwiftUI

struct DSCategoryGridSection: View {
    let title: String
    let categories: [CategoryItem]
    var selectedId: UUID? = nil
    var columns: Int = 4
    var onSelect: ((UUID) -> Void)? = nil

    struct CategoryItem: Identifiable {
        let id: UUID
        let icon: String
        let name: String
        let color: Color
    }

    var body: some View {
        VStack(alignment: .leading, spacing: M3Spacing.md) {
            DSSectionHeader(title: title)

            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: M3Spacing.sm), count: columns),
                spacing: M3Spacing.md
            ) {
                ForEach(categories) { category in
                    DSCategoryCell(
                        icon: category.icon,
                        name: category.name,
                        color: category.color,
                        isSelected: selectedId == category.id
                    ) {
                        onSelect?(category.id)
                    }
                }
            }
        }
    }
}
