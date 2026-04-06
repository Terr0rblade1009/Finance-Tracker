import SwiftUI
import Figma

struct DSNavBar_connection: FigmaConnect {
    let component = DSNavBar.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=221-16"

    @FigmaEnum(
        "style",
        mapping: [
            "title-only": NavBarStyle.titleOnly,
            "back-title": NavBarStyle.backTitle,
            "back-title-trailing": NavBarStyle.backTitleTrailing,
            "title-trailing": NavBarStyle.titleTrailing,
        ]
    )
    var style: NavBarStyle = .titleOnly

    var body: some View {
        DSNavBar(
            title: "记账本",
            backAction: self.style.hasBack ? { } : nil,
            trailingIcon: self.style.hasTrailing ? "plus.circle.fill" : nil,
            trailingAction: self.style.hasTrailing ? { } : nil
        )
    }
}

enum NavBarStyle {
    case titleOnly, backTitle, backTitleTrailing, titleTrailing

    var hasBack: Bool {
        self == .backTitle || self == .backTitleTrailing
    }

    var hasTrailing: Bool {
        self == .backTitleTrailing || self == .titleTrailing
    }
}

#Preview { DSNavBar_connection() }
