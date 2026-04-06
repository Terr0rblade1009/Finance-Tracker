import SwiftUI

struct DSImportCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: M3Spacing.md) {
                ZStack {
                    Circle()
                        .fill(color.opacity(0.12))
                        .frame(width: 56, height: 56)
                    Image(systemName: icon)
                        .font(.system(size: 24))
                        .foregroundColor(color)
                }

                VStack(spacing: 2) {
                    Text(title)
                        .font(M3Typography.labelLarge)
                        .foregroundColor(M3Color.Adaptive.onSurface)
                    Text(subtitle)
                        .font(M3Typography.labelSmall)
                        .foregroundColor(M3Color.Adaptive.outline)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, M3Spacing.xl)
            .background(M3Color.Adaptive.surfaceContainerLow)
            .clipShape(RoundedRectangle(cornerRadius: M3Radius.large))
        }
    }
}
