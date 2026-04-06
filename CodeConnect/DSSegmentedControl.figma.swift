import Figma
import SwiftUI

struct DSSegmentedControlFigma: FigmaConnect {
    let component = DSSegmentedControl.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=142-33"

    @FigmaEnum("tabs",
        mapping: ["2": "2", "3": "3"]
    )
    var tabCount: String = "2"

    @FigmaString("Tab 1")
    var tab1: String = "支出"

    @FigmaString("Tab 2")
    var tab2: String = "收入"

    @FigmaString("Tab 3")
    var tab3: String = "月"

    var body: some View {
        DSSegmentedControl(
            items: tabCount == "3" ? [tab1, tab2, tab3] : [tab1, tab2],
            selectedIndex: .constant(0)
        )
    }
}
