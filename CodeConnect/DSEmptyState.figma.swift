import Figma
import SwiftUI

struct DSEmptyState_withSubtitle: FigmaConnect {
    let component = DSEmptyState.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=134-9"
    let variant = ["hasSubtitle": "true"]

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
            subtitle: self.subtitle
        )
    }
}

struct DSEmptyState_noSubtitle: FigmaConnect {
    let component = DSEmptyState.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=134-9"
    let variant = ["hasSubtitle": "false"]

    @FigmaString("Title")
    var title: String = "暂无数据"

    @FigmaString("Icon Name")
    var iconName: String = "tray"

    var body: some View {
        DSEmptyState(
            icon: self.iconName,
            title: self.title
        )
    }
}
