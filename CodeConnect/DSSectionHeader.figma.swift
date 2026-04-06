import SwiftUI
import Figma

struct DSSectionHeader_connection: FigmaConnect {
    let component = DSSectionHeader.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=224-8"

    @FigmaBoolean("hasTrailing")
    var hasTrailing: Bool = false

    @FigmaString("Title")
    var title: String = "分类"

    var body: some View {
        DSSectionHeader(
            title: self.title,
            trailing: self.hasTrailing ? "查看全部" : nil,
            trailingAction: self.hasTrailing ? { } : nil
        )
    }
}

#Preview { DSSectionHeader_connection() }
