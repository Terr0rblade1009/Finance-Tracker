import Figma
import SwiftUI

struct DSImportCardFigma: FigmaConnect {
    let component = DSImportCard.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=136-2"

    @FigmaString("Title")
    var title: String = "拍照记账"

    @FigmaString("Subtitle")
    var subtitle: String = "拍摄照片识别账单"

    @FigmaString("Icon Name")
    var iconName: String = "envelope.open.fill"

    var body: some View {
        DSImportCard(
            icon: iconName,
            title: title,
            subtitle: subtitle,
            color: .green
        ) {}
    }
}
