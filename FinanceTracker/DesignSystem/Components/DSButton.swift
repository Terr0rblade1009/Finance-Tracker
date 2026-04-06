import SwiftUI

// MARK: - M3 Button Variants

enum DSButtonVariant {
    case filled
    case tonal
    case outlined
    case text
    case elevated
}

enum DSButtonSize {
    case small, medium, large

    var font: Font {
        switch self {
        case .small: return M3Typography.labelMedium
        case .medium: return M3Typography.labelLarge
        case .large: return M3Typography.titleSmall
        }
    }

    var horizontalPadding: CGFloat {
        switch self {
        case .small: return M3Spacing.md
        case .medium: return M3Spacing.xl
        case .large: return M3Spacing.xxl
        }
    }

    var verticalPadding: CGFloat {
        switch self {
        case .small: return M3Spacing.sm
        case .medium: return M3Spacing.md
        case .large: return M3Spacing.base
        }
    }

    var iconSize: CGFloat {
        switch self {
        case .small: return 16
        case .medium: return 18
        case .large: return 20
        }
    }
}

struct DSButton: View {
    let title: String
    var icon: String?
    var variant: DSButtonVariant = .filled
    var size: DSButtonSize = .medium
    var isFullWidth: Bool = false
    var isLoading: Bool = false
    var isDisabled: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: M3Spacing.sm) {
                if isLoading {
                    ProgressView()
                        .scaleEffect(0.8)
                        .tint(foregroundColor)
                } else {
                    if let icon {
                        Image(systemName: icon)
                            .font(.system(size: size.iconSize))
                    }
                    Text(title)
                        .font(size.font)
                }
            }
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .padding(.horizontal, size.horizontalPadding)
            .padding(.vertical, size.verticalPadding)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: M3Radius.full))
            .overlay(
                RoundedRectangle(cornerRadius: M3Radius.full)
                    .strokeBorder(borderColor, lineWidth: variant == .outlined ? 1 : 0)
            )
            .m3Shadow(variant == .elevated ? M3Elevation.level1 : M3Elevation.level0)
        }
        .disabled(isDisabled || isLoading)
        .opacity(isDisabled ? 0.38 : 1)
    }

    private var foregroundColor: Color {
        switch variant {
        case .filled: return M3Color.Adaptive.onPrimary
        case .tonal: return M3Color.Adaptive.onSecondaryContainer
        case .outlined, .text: return M3Color.Adaptive.primary
        case .elevated: return M3Color.Adaptive.primary
        }
    }

    private var backgroundColor: Color {
        switch variant {
        case .filled: return M3Color.Adaptive.primary
        case .tonal: return M3Color.Adaptive.secondaryContainer
        case .outlined, .text: return .clear
        case .elevated: return M3Color.Adaptive.surfaceContainerLow
        }
    }

    private var borderColor: Color {
        variant == .outlined ? M3Color.Adaptive.outline : .clear
    }
}
