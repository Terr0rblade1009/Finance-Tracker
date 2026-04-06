import SwiftUI

struct DSSummaryCard: View {
    let title: String
    let amount: String
    var titleDotColor: Color? = nil
    var secondaryItems: [DSStatItem] = []

    var body: some View {
        DSCard(variant: .filled) {
            VStack(spacing: M3Spacing.base) {
                HStack {
                    VStack(alignment: .leading, spacing: M3Spacing.xs) {
                        HStack(spacing: M3Spacing.xs) {
                            if let dotColor = titleDotColor {
                                Circle()
                                    .fill(dotColor)
                                    .frame(width: 8, height: 8)
                            }
                            Text(title)
                                .font(M3Typography.labelMedium)
                                .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                        }
                        Text(amount)
                            .font(M3Typography.amountLarge)
                            .foregroundColor(M3Color.Adaptive.onSurface)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                    }
                    Spacer()
                }

                if !secondaryItems.isEmpty {
                    DSStatRow(items: secondaryItems)
                }
            }
            .padding(M3Spacing.xl)
        }
    }
}
