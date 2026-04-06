import SwiftUI

enum DSChipVariant {
    case filter
    case suggestion
    case input
}

struct DSChip: View {
    let label: String
    var icon: String?
    var variant: DSChipVariant = .filter
    var isSelected: Bool = false
    var color: Color?
    var action: (() -> Void)?

    var body: some View {
        Button(action: { action?() }) {
            HStack(spacing: M3Spacing.sm) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 16))
                }
                Text(label)
                    .font(M3Typography.labelLarge)
            }
            .padding(.horizontal, M3Spacing.base)
            .padding(.vertical, M3Spacing.sm)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: M3Radius.small))
            .overlay(
                RoundedRectangle(cornerRadius: M3Radius.small)
                    .strokeBorder(
                        isSelected ? .clear : M3Color.Adaptive.outline,
                        lineWidth: 1
                    )
            )
        }
        .buttonStyle(.plain)
    }

    private var foregroundColor: Color {
        if isSelected {
            return M3Color.Adaptive.onSecondaryContainer
        }
        return M3Color.Adaptive.onSurfaceVariant
    }

    private var backgroundColor: Color {
        if isSelected {
            return color?.opacity(0.2) ?? M3Color.Adaptive.secondaryContainer
        }
        return M3Color.Adaptive.surfaceContainerLow
    }
}
