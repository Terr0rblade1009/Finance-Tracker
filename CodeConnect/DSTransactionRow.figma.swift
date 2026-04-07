import Figma
import SwiftUI

struct DSTransactionRow_withSubtitle: FigmaConnect {
    let component = DSTransactionRow.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=137-19"
    let variant = ["hasSubtitle": "true"]

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
            icon: self.iconName,
            iconColor: Color(hex: "FF8A65"),
            title: self.title,
            subtitle: self.subtitle,
            trailingTop: self.amount,
            trailingBottom: self.date
        )
    }
}

struct DSTransactionRow_noSubtitle: FigmaConnect {
    let component = DSTransactionRow.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=137-19"
    let variant = ["hasSubtitle": "false"]

    @FigmaString("Title")
    var title: String = "餐饮"

    @FigmaString("Amount")
    var amount: String = "-¥25.00"

    @FigmaString("Date")
    var date: String = "04/06"

    @FigmaString("Icon Name")
    var iconName: String = "fork.knife"

    var body: some View {
        DSTransactionRow(
            icon: self.iconName,
            iconColor: Color(hex: "FF8A65"),
            title: self.title,
            trailingTop: self.amount,
            trailingBottom: self.date
        )
    }
}
