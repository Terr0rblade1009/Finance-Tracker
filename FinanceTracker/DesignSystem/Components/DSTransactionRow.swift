import SwiftUI

struct DSTransactionRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    var subtitle: String? = nil
    var trailingTop: String
    var trailingBottom: String? = nil
    var trailingTopColor: Color = M3Color.Adaptive.onSurface

    var body: some View {
        HStack(spacing: M3Spacing.md) {
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.15))
                    .frame(width: 44, height: 44)
                Image(systemName: icon)
                    .font(.system(size: M3IconSize.small))
                    .foregroundColor(iconColor)
            }

            VStack(alignment: .leading, spacing: M3Spacing.xxs) {
                Text(title)
                    .font(M3Typography.titleSmall)
                    .foregroundColor(M3Color.Adaptive.onSurface)
                if let subtitle, !subtitle.isEmpty {
                    Text(subtitle)
                        .font(M3Typography.bodySmall)
                        .foregroundColor(M3Color.Adaptive.outline)
                        .lineLimit(1)
                }
            }

            Spacer()

            VStack(alignment: .trailing, spacing: M3Spacing.xxs) {
                Text(trailingTop)
                    .font(M3Typography.titleSmall)
                    .foregroundColor(trailingTopColor)
                if let trailingBottom {
                    Text(trailingBottom)
                        .font(M3Typography.labelSmall)
                        .foregroundColor(M3Color.Adaptive.outline)
                }
            }
        }
        .padding(M3Spacing.md)
        .background(M3Color.Adaptive.surfaceContainerLow)
        .clipShape(RoundedRectangle(cornerRadius: M3Radius.medium))
    }
}
