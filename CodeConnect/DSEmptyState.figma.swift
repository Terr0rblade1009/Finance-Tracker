import Figma
import SwiftUI

struct DSEmptyStateFigma: FigmaConnect {
    let component = DSEmptyState.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=134-9"

    @FigmaBoolean("hasSubtitle")
    var hasSubtitle: Bool

    @FigmaString("Title")
    var title: String

    @FigmaString("Subtitle")
    var subtitle: String

    var body: some View {
        DSEmptyState(
            icon: "tray",
            title: title,
            subtitle: hasSubtitle ? subtitle : nil
        )
    }
}
