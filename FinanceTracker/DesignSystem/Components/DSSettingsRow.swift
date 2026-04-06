import SwiftUI

struct DSSettingsRow: View {
    let icon: String
    let title: String
    let color: String

    var body: some View {
        HStack(spacing: M3Spacing.md) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(Color(hex: color))
                .clipShape(RoundedRectangle(cornerRadius: 6))
            Text(title)
                .font(M3Typography.bodyLarge)
                .foregroundColor(M3Color.Adaptive.onSurface)
        }
    }
}
