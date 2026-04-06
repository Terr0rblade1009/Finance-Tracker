import Figma
import SwiftUI

struct DSCategoryCellFigma: FigmaConnect {
    let component = DSCategoryCell.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=144-10"

    @FigmaBoolean("selected")
    var isSelected: Bool = false

    @FigmaString("Name")
    var name: String = "餐饮"

    @FigmaString("Icon Name")
    var iconName: String = "fork.knife"

    var body: some View {
        DSCategoryCell(
            icon: iconName,
            name: name,
            color: Color(hex: "FF8A65"),
            isSelected: isSelected
        )
    }
}
