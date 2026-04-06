import Figma
import SwiftUI

struct DSTransactionRowFigma: FigmaConnect {
    let component = DSTransactionRow.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=137-19"

    @FigmaBoolean("hasSubtitle")
    var hasSubtitle: Bool

    @FigmaString("Title")
    var title: String

    @FigmaString("Subtitle")
    var subtitle: String

    @FigmaString("Amount")
    var amount: String

    @FigmaString("Date")
    var date: String

    var body: some View {
        DSTransactionRow(
            icon: "fork.knife",
            iconColor: Color(hex: "FF8A65"),
            title: title,
            subtitle: hasSubtitle ? subtitle : nil,
            trailingTop: amount,
            trailingBottom: date
        )
    }
}
