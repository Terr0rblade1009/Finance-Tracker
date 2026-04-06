import SwiftUI

struct DSCategoryCell: View {
    let icon: String
    let name: String
    let color: Color
    var isSelected: Bool = false
    var action: (() -> Void)? = nil

    var body: some View {
        Button {
            action?()
        } label: {
            VStack(spacing: M3Spacing.xs) {
                ZStack {
                    Circle()
                        .fill(color.opacity(isSelected ? 0.25 : 0.1))
                        .frame(width: 48, height: 48)
                        .overlay(
                            Circle()
                                .strokeBorder(isSelected ? color : Color.clear, lineWidth: 2)
                        )

                    Image(systemName: icon)
                        .font(.system(size: M3IconSize.medium))
                        .foregroundColor(color)
                }

                Text(name)
                    .font(M3Typography.labelSmall)
                    .foregroundColor(M3Color.Adaptive.onSurface)
                    .lineLimit(1)
            }
        }
        .buttonStyle(.plain)
    }
}
