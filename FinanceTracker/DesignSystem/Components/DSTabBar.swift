import SwiftUI

struct DSTabBar: View {
    @Binding var selectedTab: Int
    var onCenterTap: () -> Void

    struct TabItem {
        let icon: String
        let label: String
        let tag: Int
    }

    var items: [TabItem] = [
        TabItem(icon: "house.fill", label: L("首页"), tag: 0),
        TabItem(icon: "chart.pie.fill", label: L("分析"), tag: 1),
        TabItem(icon: "tray.and.arrow.down.fill", label: L("导入"), tag: 3),
        TabItem(icon: "gearshape.fill", label: L("设置"), tag: 4),
    ]

    var body: some View {
        HStack(spacing: 0) {
            tabButton(items[0])
            tabButton(items[1])
            centerButton
            tabButton(items[2])
            tabButton(items[3])
        }
        .padding(.horizontal, M3Spacing.sm)
        .padding(.top, M3Spacing.sm)
        .padding(.bottom, M3Spacing.xxl)
        .background(
            M3Color.Adaptive.surfaceContainer
                .shadow(color: .black.opacity(0.08), radius: 8, y: -2)
        )
    }

    private func tabButton(_ item: TabItem) -> some View {
        Button {
            withAnimation(.spring(response: 0.25)) {
                selectedTab = item.tag
            }
        } label: {
            VStack(spacing: M3Spacing.xxs) {
                Image(systemName: item.icon)
                    .font(.system(size: M3IconSize.medium))
                    .symbolEffect(.bounce, value: selectedTab == item.tag)
                Text(item.label)
                    .font(M3Typography.labelSmall)
            }
            .foregroundColor(selectedTab == item.tag ? M3Color.Adaptive.primary : M3Color.Adaptive.onSurfaceVariant)
            .frame(maxWidth: .infinity)
        }
    }

    private var centerButton: some View {
        Button(action: onCenterTap) {
            ZStack {
                Circle()
                    .fill(M3Color.Adaptive.primary)
                    .frame(width: 56, height: 56)
                    .m3Shadow(M3Elevation.level3)

                Image(systemName: "plus")
                    .font(.system(size: M3IconSize.medium, weight: .medium))
                    .foregroundColor(M3Color.Adaptive.onPrimary)
            }
        }
        .offset(y: -M3Spacing.lg)
        .frame(maxWidth: .infinity)
    }
}
