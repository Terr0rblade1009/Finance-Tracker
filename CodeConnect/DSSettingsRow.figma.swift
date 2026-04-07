import Figma
import SwiftUI

struct DSSettingsRowFigma: FigmaConnect {
    let component = DSSettingsRow.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=135-12"

    @FigmaString("Title")
    var title: String = "账户管理"

    @FigmaString("Icon Name")
    var iconName: String = "wallet.pass.fill"

    var body: some View {
        DSSettingsRow(
            icon: self.iconName,
            title: self.title,
            color: "42A5F5"
        )
    }
}
