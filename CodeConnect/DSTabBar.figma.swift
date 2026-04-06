import SwiftUI
import Figma

struct DSTabBar_connection: FigmaConnect {
    let component = DSTabBar.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=222-3"

    var body: some View {
        DSTabBar(selectedTab: .constant(0)) {
            // center FAB action
        }
    }
}

#Preview { DSTabBar_connection() }
