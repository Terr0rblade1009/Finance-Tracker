import SwiftUI
import Charts

struct DSPieChartItem: Identifiable {
    let id = UUID()
    let name: String
    let amount: Double
    let colorHex: String
    let percentage: Double
}

struct DSPieChartCard: View {
    let title: String
    let data: [DSPieChartItem]

    var body: some View {
        DSCard(variant: .outlined) {
            VStack(alignment: .leading, spacing: M3Spacing.md) {
                Text(title)
                    .font(M3Typography.titleMedium)
                    .foregroundColor(M3Color.Adaptive.onSurface)

                HStack(spacing: M3Spacing.base) {
                    Chart(data) { item in
                        SectorMark(
                            angle: .value(L("金额"), item.amount),
                            innerRadius: .ratio(0.55),
                            angularInset: 1.5
                        )
                        .foregroundStyle(Color(hex: item.colorHex))
                        .cornerRadius(3)
                    }
                    .frame(width: 140, height: 140)

                    VStack(alignment: .leading, spacing: M3Spacing.sm) {
                        ForEach(data.prefix(5)) { item in
                            HStack(spacing: M3Spacing.sm) {
                                Circle()
                                    .fill(Color(hex: item.colorHex))
                                    .frame(width: 8, height: 8)
                                Text(item.name)
                                    .font(M3Typography.labelSmall)
                                    .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                                    .lineLimit(1)
                                Spacer()
                                Text(String(format: "%.0f%%", item.percentage))
                                    .font(M3Typography.labelSmall)
                                    .foregroundColor(M3Color.Adaptive.outline)
                            }
                        }
                    }
                }
            }
            .padding(M3Spacing.base)
        }
    }
}
