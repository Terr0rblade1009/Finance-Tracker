import SwiftUI
import Figma

struct DSSectionHeader_withTrailing: FigmaConnect {
    let component = DSSectionHeader.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=224-8"
    let variant = ["hasTrailing": "true"]

    var body: some View {
        DSSectionHeader(
            title: "分类",
            trailing: "查看全部",
            trailingAction: { }
        )
    }
}

struct DSSectionHeader_noTrailing: FigmaConnect {
    let component = DSSectionHeader.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=224-8"
    let variant = ["hasTrailing": "false"]

    var body: some View {
        DSSectionHeader(
            title: "分类"
        )
    }
}
