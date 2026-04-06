import Figma
import SwiftUI

struct DSDialogFigma: FigmaConnect {
    let component = DSDialog.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=414-33"

    @FigmaString("Title")
    var title: String = "Confirm deletion"

    @FigmaString("Message")
    var message: String = "This action cannot be undone. Are you sure you want to delete this record?"

    var body: some View {
        DSDialog(
            isPresented: .constant(true),
            title: title,
            message: message
        ) {
            // onConfirm action
        }
    }
}
