import SwiftUI

// MARK: - M3 Card Variants

enum DSCardVariant {
    case elevated
    case filled
    case outlined
}

struct DSCard<Content: View>: View {
    var variant: DSCardVariant = .filled
    var cornerRadius: CGFloat = M3Radius.large
    @ViewBuilder let content: () -> Content

    var body: some View {
        content()
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(borderColor, lineWidth: variant == .outlined ? 1 : 0)
            )
            .m3Shadow(shadowStyle)
    }

    private var backgroundColor: Color {
        switch variant {
        case .elevated: return M3Color.Adaptive.surfaceContainerLow
        case .filled: return M3Color.Adaptive.surfaceContainerHighest
        case .outlined: return M3Color.Adaptive.surface
        }
    }

    private var borderColor: Color {
        variant == .outlined ? M3Color.Adaptive.outlineVariant : .clear
    }

    private var shadowStyle: M3Elevation.ShadowStyle {
        variant == .elevated ? M3Elevation.level1 : M3Elevation.level0
    }
}
