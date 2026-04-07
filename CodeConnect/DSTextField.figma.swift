import SwiftUI
import Figma

struct DSTextField_default_connection: FigmaConnect {
    let component = DSTextField.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=24-16"
    let variant = ["state": "default"]

    @FigmaString("Label Text")
    var label: String = "Label"

    @FigmaBoolean("Show Icon", hideDefault: true)
    var showIcon: Bool = false

    var body: some View {
        DSTextField(
            label: self.label,
            text: .constant(""),
            icon: self.showIcon ? "magnifyingglass" : nil
        )
    }
}

struct DSTextField_focused_connection: FigmaConnect {
    let component = DSTextField.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=24-16"
    let variant = ["state": "focused"]

    @FigmaString("Label Text")
    var label: String = "Label"

    @FigmaString("Placeholder")
    var placeholder: String = "Input text"

    @FigmaBoolean("Show Icon", hideDefault: true)
    var showIcon: Bool = false

    var body: some View {
        DSTextField(
            label: self.label,
            text: .constant(self.placeholder),
            icon: self.showIcon ? "magnifyingglass" : nil
        )
    }
}

struct DSTextField_error_connection: FigmaConnect {
    let component = DSTextField.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=24-16"
    let variant = ["state": "error"]

    @FigmaString("Label Text")
    var label: String = "Label"

    @FigmaString("Placeholder")
    var placeholder: String = "Input text"

    @FigmaBoolean("Show Icon", hideDefault: true)
    var showIcon: Bool = false

    var body: some View {
        DSTextField(
            label: self.label,
            text: .constant(self.placeholder),
            icon: self.showIcon ? "magnifyingglass" : nil,
            errorMessage: "Error message"
        )
    }
}

#Preview { DSTextField_default_connection() }
