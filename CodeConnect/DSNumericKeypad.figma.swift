import SwiftUI
import Figma

struct DSNumericKeypad_connection: FigmaConnect {
    let component = DSNumericKeypad.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=28-2"

    var body: some View {
        DSNumericKeypad(value: .constant("0")) {
            // onConfirm
        }
    }
}

#Preview { DSNumericKeypad_connection() }
