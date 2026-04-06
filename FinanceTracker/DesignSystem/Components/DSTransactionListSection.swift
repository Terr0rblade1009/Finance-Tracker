import SwiftUI

struct DSTransactionListSection<Row: View>: View {
    let title: String
    @ViewBuilder let rows: () -> Row

    var body: some View {
        VStack(alignment: .leading, spacing: M3Spacing.md) {
            Text(title)
                .font(M3Typography.titleMedium)
                .foregroundColor(M3Color.Adaptive.onSurface)

            LazyVStack(spacing: M3Spacing.sm) {
                rows()
            }
        }
    }
}
