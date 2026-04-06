import SwiftUI
import Figma

struct DSSearchBar_connection: FigmaConnect {
    let component = DSSearchBar.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=27-2"

    @FigmaString("Placeholder")
    var placeholder: String = "Search"

    var body: some View {
        DSSearchBar(
            text: .constant(""),
            placeholder: self.placeholder
        )
    }
}

#Preview { DSSearchBar_connection() }
