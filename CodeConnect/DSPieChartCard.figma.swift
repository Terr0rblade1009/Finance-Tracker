import Figma
import SwiftUI

struct DSPieChartCardFigma: FigmaConnect {
    let component = DSPieChartCard.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=145-2"

    @FigmaString("Title")
    var title: String = "支出构成"

    var body: some View {
        DSPieChartCard(
            title: title,
            data: [
                DSPieChartItem(name: "餐饮", amount: 66, colorHex: "FF8A65", percentage: 73),
                DSPieChartItem(name: "交通", amount: 25, colorHex: "4FC3F7", percentage: 27)
            ]
        )
    }
}
