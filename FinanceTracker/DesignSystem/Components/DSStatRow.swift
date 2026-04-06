import SwiftUI

struct DSStatItem {
    let label: String
    let value: String
    var color: Color = M3Color.Adaptive.onSurface
}

struct DSStatRow: View {
    let items: [DSStatItem]

    var body: some View {
        HStack {
            ForEach(items.indices, id: \.self) { index in
                if index > 0 { Spacer() }
                VStack(spacing: M3Spacing.xxs) {
                    Text(items[index].label)
                        .font(M3Typography.labelSmall)
                        .foregroundColor(M3Color.Adaptive.outline)
                    Text(items[index].value)
                        .font(M3Typography.titleSmall)
                        .foregroundColor(items[index].color)
                }
            }
        }
    }
}
