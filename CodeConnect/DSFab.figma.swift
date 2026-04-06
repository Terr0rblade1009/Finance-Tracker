import SwiftUI
import Figma

struct DSFab_small_connection: FigmaConnect {
    let component = DSFab.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=26-11"
    let variant = ["size": "small"]

    var body: some View {
        DSFab(icon: "plus", size: .small) {
            // action
        }
    }
}

struct DSFab_regular_connection: FigmaConnect {
    let component = DSFab.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=26-11"
    let variant = ["size": "regular"]

    var body: some View {
        DSFab(icon: "plus", size: .regular) {
            // action
        }
    }
}

struct DSFab_large_connection: FigmaConnect {
    let component = DSFab.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=26-11"
    let variant = ["size": "large"]

    var body: some View {
        DSFab(icon: "plus", size: .large) {
            // action
        }
    }
}

struct DSFab_extended_connection: FigmaConnect {
    let component = DSFab.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=26-11"
    let variant = ["size": "extended"]

    @FigmaString("Label")
    var label: String = "Create"

    var body: some View {
        DSFab(icon: "plus", extended: self.label) {
            // action
        }
    }
}

#Preview { DSFab_regular_connection() }
