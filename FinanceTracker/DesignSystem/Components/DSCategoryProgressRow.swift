import SwiftUI

struct DSCategoryProgressRow: View {
    let icon: String
    let name: String
    let count: Int
    let amount: String
    let percentage: Double
    let color: Color

    var body: some View {
        VStack(spacing: M3Spacing.sm) {
            HStack(spacing: M3Spacing.md) {
                ZStack {
                    Circle()
                        .fill(color.opacity(0.15))
                        .frame(width: 40, height: 40)
                    Image(systemName: icon)
                        .font(.system(size: M3IconSize.medium))
                        .foregroundColor(color)
                }

                VStack(alignment: .leading, spacing: M3Spacing.xxs) {
                    Text(name)
                        .font(M3Typography.titleSmall)
                        .foregroundColor(M3Color.Adaptive.onSurface)
                    Text("\(count) \(L("笔"))")
                        .font(M3Typography.labelSmall)
                        .foregroundColor(M3Color.Adaptive.outline)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: M3Spacing.xxs) {
                    Text(amount)
                        .font(M3Typography.titleSmall)
                        .foregroundColor(M3Color.Adaptive.onSurface)
                    Text(String(format: "%.1f%%", percentage))
                        .font(M3Typography.labelSmall)
                        .foregroundColor(M3Color.Adaptive.outline)
                }
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(M3Color.Adaptive.surfaceContainerHigh)
                        .frame(height: 4)
                    RoundedRectangle(cornerRadius: 2)
                        .fill(color)
                        .frame(width: geo.size.width * (percentage / 100), height: 4)
                }
            }
            .frame(height: 4)
        }
        .padding(M3Spacing.md)
        .background(M3Color.Adaptive.surfaceContainerLow)
        .clipShape(RoundedRectangle(cornerRadius: M3Radius.medium))
    }
}
