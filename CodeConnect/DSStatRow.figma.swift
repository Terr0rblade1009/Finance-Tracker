import Figma
import SwiftUI

struct DSStatRowFigma: FigmaConnect {
    let component = DSStatRow.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=139-19"

    @FigmaEnum("count",
        mapping: ["2": "2", "3": "3"]
    )
    var count: String = "2"

    @FigmaString("Label 1")
    var label1: String = "支出"

    @FigmaString("Value 1")
    var value1: String = "¥91.00"

    @FigmaString("Label 2")
    var label2: String = "收入"

    @FigmaString("Value 2")
    var value2: String = "¥0.00"

    @FigmaString("Label 3")
    var label3: String = "结余"

    @FigmaString("Value 3")
    var value3: String = "-¥91.00"

    var body: some View {
        DSStatRow(items: {
            var items = [
                DSStatItem(label: label1, value: value1, color: .red),
                DSStatItem(label: label2, value: value2)
            ]
            if count == "3" {
                items.append(DSStatItem(label: label3, value: value3))
            }
            return items
        }())
    }
}
