import Figma
import SwiftUI

struct DSSegmentedControlFigma: FigmaConnect {
    let component = DSSegmentedControl.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=142-33"

    @FigmaString("Tab 1")
    var tab1: String

    @FigmaString("Tab 2")
    var tab2: String

    var body: some View {
        DSSegmentedControl(
            items: [tab1, tab2],
            selectedIndex: .constant(0)
        )
    }
}
