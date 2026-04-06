import SwiftUI

enum DSFabSize {
    case small, regular, large

    var fixedSize: CGFloat? {
        switch self {
        case .small: return 40
        case .regular: return nil
        case .large: return 96
        }
    }

    var containerPadding: CGFloat {
        switch self {
        case .regular: return M3Spacing.base
        default: return 0
        }
    }

    var iconSize: CGFloat {
        switch self {
        case .small: return 20
        case .regular: return 24
        case .large: return 36
        }
    }

    var radius: CGFloat {
        switch self {
        case .small: return M3Radius.medium
        case .regular: return M3Radius.large
        case .large: return M3Radius.extraLarge
        }
    }
}

struct DSFab: View {
    let icon: String
    var size: DSFabSize = .regular
    var extended: String?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: M3Spacing.md) {
                Image(systemName: icon)
                    .font(.system(size: size.iconSize, weight: .medium))
                if let extended {
                    Text(extended)
                        .font(M3Typography.labelLarge)
                }
            }
            .foregroundColor(M3Color.Adaptive.onPrimaryContainer)
            .padding(extended != nil ? M3Spacing.base : size.containerPadding)
            .frame(
                width: extended == nil ? size.fixedSize : nil,
                height: extended == nil ? size.fixedSize : nil
            )
            .background(M3Color.Adaptive.primaryContainer)
            .clipShape(RoundedRectangle(cornerRadius: size.radius))
            .m3Shadow(M3Elevation.level3)
        }
    }
}
