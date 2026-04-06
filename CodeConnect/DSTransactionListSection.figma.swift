import SwiftUI
import Figma

struct DSTransactionListSection_connection: FigmaConnect {
    let component = DSTransactionListSection.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=229-3"

    var body: some View {
        DSTransactionListSection(title: "本月明细") {
            Text("Transaction rows go here")
        }
    }
}

#Preview { DSTransactionListSection_connection() }
