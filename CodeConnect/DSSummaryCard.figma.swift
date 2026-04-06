import Figma
import SwiftUI

struct DSSummaryCardFigma: FigmaConnect {
    let component = DSSummaryCard.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=140-18"

    @FigmaEnum("style",
        mapping: ["detailed": "detailed", "simple": "simple"]
    )
    var cardStyle: String

    @FigmaString("Title")
    var title: String

    @FigmaString("Amount")
    var amount: String

    var body: some View {
        DSSummaryCard(
            title: title,
            amount: amount,
            titleDotColor: cardStyle == "detailed" ? .red : nil,
            secondaryItems: cardStyle == "detailed" ? [
                DSStatItem(label: "总收入", value: "¥0.00"),
                DSStatItem(label: "月结余", value: "-¥91.00", color: .red)
            ] : []
        )
    }
}
