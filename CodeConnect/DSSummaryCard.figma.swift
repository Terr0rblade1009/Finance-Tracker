import Figma
import SwiftUI

struct DSSummaryCardFigma: FigmaConnect {
    let component = DSSummaryCard.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=140-18"

    @FigmaEnum("style",
        mapping: ["detailed": "detailed", "simple": "simple"]
    )
    var cardStyle: String = "detailed"

    @FigmaString("Title")
    var title: String = "本月支出"

    @FigmaString("Amount")
    var amount: String = "¥91.00"

    @FigmaString("Stat Label 1")
    var statLabel1: String = "总收入"

    @FigmaString("Stat Value 1")
    var statValue1: String = "¥0.00"

    @FigmaString("Stat Label 2")
    var statLabel2: String = "月结余"

    @FigmaString("Stat Value 2")
    var statValue2: String = "-¥91.00"

    var body: some View {
        DSSummaryCard(
            title: title,
            amount: amount,
            titleDotColor: cardStyle == "detailed" ? .red : nil,
            secondaryItems: cardStyle == "detailed" ? [
                DSStatItem(label: statLabel1, value: statValue1),
                DSStatItem(label: statLabel2, value: statValue2, color: .red)
            ] : []
        )
    }
}
