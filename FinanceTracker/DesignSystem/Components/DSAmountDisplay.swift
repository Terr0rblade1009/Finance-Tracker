import SwiftUI

struct DSAmountDisplay: View {
    let label: String
    let amount: String
    var currencySymbol: String = "$"

    var body: some View {
        VStack(spacing: M3Spacing.xs) {
            Text(LocalizedStringKey(label))
                .font(M3Typography.labelMedium)
                .foregroundColor(M3Color.Adaptive.onSurfaceVariant)

            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(currencySymbol)
                    .font(M3Typography.headlineMedium)
                    .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                Text(amount)
                    .font(M3Typography.amountLarge)
                    .foregroundColor(M3Color.Adaptive.onSurface)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, M3Spacing.lg)
    }
}
