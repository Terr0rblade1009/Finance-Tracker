import Figma
import SwiftUI

struct DSCategoryCellFigma: FigmaConnect {
    let component = DSCategoryCell.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=144-10"

    @FigmaBoolean("selected")
    var isSelected: Bool

    @FigmaString("Name")
    var name: String

    var body: some View {
        DSCategoryCell(
            icon: "fork.knife",
            name: name,
            color: Color(hex: "FF8A65"),
            isSelected: isSelected
        )
    }
}
