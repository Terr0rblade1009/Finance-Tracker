import Figma
import SwiftUI

struct DSMethodCardFigma: FigmaConnect {
    let component = DSMethodCard.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=418-3"

    var body: some View {
        DSMethodCard(
            iconColor: .green,
            icon: "pencil.line",
            title: "Manual Input",
            subtitle: "Enter amount, category and notes"
        )
    }
}
