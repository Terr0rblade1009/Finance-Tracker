import Figma
import SwiftUI

struct DSMonthNavigatorFigma: FigmaConnect {
    let component = DSMonthNavigator<EmptyView>.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=143-19"

    @FigmaEnum("style",
        mapping: ["compact": "compact", "prominent": "prominent"]
    )
    var navStyle: String

    var body: some View {
        DSMonthNavigator(
            currentDate: .constant(Date()),
            style: navStyle == "prominent" ? .prominent : .compact
        )
    }
}
