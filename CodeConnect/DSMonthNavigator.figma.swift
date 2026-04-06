import Figma
import SwiftUI

struct DSMonthNavigatorFigma: FigmaConnect {
    let component = DSMonthNavigator<EmptyView>.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=335-20"

    @FigmaEnum("style",
        mapping: ["compact": "compact", "prominent": "prominent"]
    )
    var navStyle: String = "compact"

    @FigmaString("Month")
    var month: String = "2026/04"

    @FigmaString("Trailing Label")
    var trailingLabel: String = "Calendar"

    var body: some View {
        DSMonthNavigator(
            currentDate: .constant(Date()),
            style: navStyle == "prominent" ? .prominent : .compact
        ) {
            if navStyle == "compact" {
                Button(trailingLabel) { }
            }
        }
    }
}
