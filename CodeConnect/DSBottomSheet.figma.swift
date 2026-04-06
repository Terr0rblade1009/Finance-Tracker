import SwiftUI
import Figma

struct DSBottomSheet_connection: FigmaConnect {
    let component = DSBottomSheet<AnyView>.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=29-2"

    @FigmaChildren(layers: ["Content"])
    var content: AnyView? = nil

    var body: some View {
        DSBottomSheet(isPresented: .constant(true)) {
            self.content
        }
    }
}

#Preview { DSBottomSheet_connection() }
