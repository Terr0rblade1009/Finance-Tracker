import SwiftUI
import Figma

struct DSAmountDisplay_connection: FigmaConnect {
    let component = DSAmountDisplay.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=228-3"

    var body: some View {
        DSAmountDisplay(
            label: "支出金额",
            amount: "0.00"
        )
    }
}

#Preview { DSAmountDisplay_connection() }
