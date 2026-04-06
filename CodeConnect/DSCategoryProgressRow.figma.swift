import SwiftUI
import Figma

struct DSCategoryProgressRow_connection: FigmaConnect {
    let component = DSCategoryProgressRow.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=227-3"

    var body: some View {
        DSCategoryProgressRow(
            icon: "fork.knife",
            name: "餐饮",
            count: 12,
            amount: "$1,234.50",
            percentage: 35.2,
            color: .orange
        )
    }
}

#Preview { DSCategoryProgressRow_connection() }
