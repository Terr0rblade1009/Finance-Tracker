import Figma
import SwiftUI

struct DSStatRowFigma: FigmaConnect {
    let component = DSStatRow.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=139-19"

    @FigmaEnum("count",
        mapping: ["2": "2", "3": "3"]
    )
    var count: String

    @FigmaString("Label 1")
    var label1: String

    @FigmaString("Value 1")
    var value1: String

    @FigmaString("Label 2")
    var label2: String

    @FigmaString("Value 2")
    var value2: String

    var body: some View {
        DSStatRow(items: [
            DSStatItem(label: label1, value: value1, color: .red),
            DSStatItem(label: label2, value: value2)
        ])
    }
}
