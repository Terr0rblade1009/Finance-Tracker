import SwiftUI

struct DSEmptyState: View {
    let icon: String
    let title: String
    var subtitle: String? = nil

    var body: some View {
        VStack(spacing: M3Spacing.base) {
            Image(systemName: icon)
                .font(.system(size: 48))
                .foregroundColor(M3Color.Adaptive.outlineVariant)
            Text(title)
                .font(M3Typography.bodyLarge)
                .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
            if let subtitle {
                Text(subtitle)
                    .font(M3Typography.bodySmall)
                    .foregroundColor(M3Color.Adaptive.outline)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, M3Spacing.huge)
    }
}
