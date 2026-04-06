import SwiftUI

struct DSMethodCard: View {
    let iconColor: Color
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: M3Spacing.base) {
            ZStack {
                Circle()
                    .fill(iconColor)
                    .frame(width: 48, height: 48)
                Image(systemName: icon)
                    .font(.system(size: M3IconSize.medium))
                    .foregroundColor(.white)
            }

            VStack(alignment: .leading, spacing: M3Spacing.xxs) {
                Text(title)
                    .font(M3Typography.titleMedium)
                    .foregroundColor(M3Color.Adaptive.onSurface)
                Text(subtitle)
                    .font(M3Typography.bodySmall)
                    .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
            }

            Spacer()
        }
        .padding(.vertical, M3Spacing.md)
        .padding(.horizontal, M3Spacing.base)
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(M3Color.Adaptive.surfaceContainerLow)
        .clipShape(RoundedRectangle(cornerRadius: M3Radius.large))
    }
}
