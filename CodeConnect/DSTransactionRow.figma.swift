import Figma
import SwiftUI

struct DSTransactionRowFigma: FigmaConnect {
    let component = DSTransactionRow.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=137-19"

    @FigmaBoolean("hasSubtitle")
    var hasSubtitle: Bool = false

    @FigmaString("Title")
    var title: String = "餐饮"

    @FigmaString("Subtitle")
    var subtitle: String = "午餐"

    @FigmaString("Amount")
    var amount: String = "-¥25.00"

    @FigmaString("Date")
    var date: String = "04/06"

    @FigmaString("Icon Name")
    var iconName: String = "fork.knife"

    var body: some View {
        DSTransactionRow(
            icon: iconName,
            iconColor: Color(hex: "FF8A65"),
            title: title,
            subtitle: hasSubtitle ? subtitle : nil,
            trailingTop: amount,
            trailingBottom: date
        )
    }
}
