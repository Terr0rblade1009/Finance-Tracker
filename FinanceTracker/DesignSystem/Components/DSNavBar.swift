import SwiftUI

struct DSNavBar: View {
    let title: String
    var backAction: (() -> Void)? = nil
    var trailingIcon: String? = nil
    var trailingAction: (() -> Void)? = nil

    var body: some View {
        HStack(spacing: M3Spacing.md) {
            if let backAction {
                Button(action: backAction) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(M3Color.Adaptive.onSurface)
                        .frame(width: 32, height: 32)
                }
            }

            if backAction != nil {
                Spacer()
            }

            Text(title)
                .font(M3Typography.titleLarge)
                .foregroundColor(M3Color.Adaptive.onSurface)

            Spacer()

            if let trailingIcon, let trailingAction {
                Button(action: trailingAction) {
                    Image(systemName: trailingIcon)
                        .font(.system(size: 20))
                        .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                        .frame(width: 32, height: 32)
                }
            }
        }
        .padding(.horizontal, M3Spacing.base)
        .padding(.vertical, M3Spacing.sm)
        .frame(height: 56)
    }
}
