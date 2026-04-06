import Figma
import SwiftUI

struct DSMethodCardFigma: FigmaConnect {
    let component = DSMethodCard.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=418-3"

    @FigmaString("Title")
    var title: String = "Manual Input"

    @FigmaString("Subtitle")
    var subtitle: String = "Enter amount, category and notes"

    var body: some View {
        DSMethodCard(
            iconColor: .green,
            icon: "pencil.line",
            title: title,
            subtitle: subtitle
        )
    }
}
