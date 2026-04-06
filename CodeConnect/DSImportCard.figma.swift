import Figma
import SwiftUI

struct DSImportCardFigma: FigmaConnect {
    let component = DSImportCard.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=136-2"

    @FigmaString("Title")
    var title: String

    @FigmaString("Subtitle")
    var subtitle: String

    var body: some View {
        DSImportCard(
            icon: "envelope.open.fill",
            title: title,
            subtitle: subtitle,
            color: .green
        ) {}
    }
}
