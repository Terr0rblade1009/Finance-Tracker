import Figma
import SwiftUI

struct DSSettingsRowFigma: FigmaConnect {
    let component = DSSettingsRow.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=135-12"

    @FigmaString("Title")
    var title: String

    var body: some View {
        DSSettingsRow(
            icon: "wallet.pass.fill",
            title: title,
            color: "42A5F5"
        )
    }
}
