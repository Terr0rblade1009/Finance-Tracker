import Figma
import SwiftUI

struct DSEmptyStateFigma: FigmaConnect {
    let component = DSEmptyState.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=134-9"

    @FigmaBoolean("hasSubtitle", hideDefault: true)
    var hasSubtitle: Bool = false

    @FigmaString("Title")
    var title: String = "暂无数据"

    @FigmaString("Subtitle")
    var subtitle: String = "开始记录你的收支"

    @FigmaString("Icon Name")
    var iconName: String = "tray"

    var body: some View {
        DSEmptyState(
            icon: self.iconName,
            title: self.title,
            subtitle: self.hasSubtitle ? self.subtitle : nil
        )
    }
}
