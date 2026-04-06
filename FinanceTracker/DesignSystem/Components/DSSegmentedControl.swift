import SwiftUI

struct DSSegmentedControl: View {
    let items: [String]
    @Binding var selectedIndex: Int

    var body: some View {
        HStack(spacing: 0) {
            ForEach(items.indices, id: \.self) { index in
                Button {
                    withAnimation(.spring(response: 0.3)) {
                        selectedIndex = index
                    }
                } label: {
                    Text(LocalizedStringKey(items[index]))
                        .font(M3Typography.labelLarge)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, M3Spacing.md)
                        .foregroundColor(
                            selectedIndex == index
                                ? M3Color.Adaptive.onPrimary
                                : M3Color.Adaptive.onSurfaceVariant
                        )
                        .background(
                            selectedIndex == index
                                ? M3Color.Adaptive.primary
                                : Color.clear
                        )
                }
            }
        }
        .background(M3Color.Adaptive.surfaceContainerHigh)
        .clipShape(RoundedRectangle(cornerRadius: M3Radius.full))
        .padding(.horizontal, M3Spacing.base)
        .padding(.vertical, M3Spacing.sm)
    }
}
