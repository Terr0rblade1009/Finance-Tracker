import Figma
import SwiftUI

struct DSDialogFigma: FigmaConnect {
    let component = DSDialog.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=414-33"

    var body: some View {
        DSDialog(
            isPresented: .constant(true),
            title: "Confirm deletion",
            message: "This action cannot be undone."
        ) {
            // onConfirm action
        }
    }
}
