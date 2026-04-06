import SwiftUI
import Figma

struct DSAmountDisplay_connection: FigmaConnect {
    let component = DSAmountDisplay.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=228-3"

    @FigmaString("Label")
    var label: String = "支出金额"

    @FigmaString("Value")
    var amount: String = "0.00"

    var body: some View {
        DSAmountDisplay(
            label: self.label,
            amount: self.amount
        )
    }
}

#Preview { DSAmountDisplay_connection() }
