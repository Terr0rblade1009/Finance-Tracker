import SwiftUI
import Figma

struct DSButton_connection: FigmaConnect {
    let component = DSButton.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=21-32"

    @FigmaEnum(
        "variant",
        mapping: [
            "filled": DSButtonVariant.filled,
            "tonal": DSButtonVariant.tonal,
            "outlined": DSButtonVariant.outlined,
            "text": DSButtonVariant.text,
            "elevated": DSButtonVariant.elevated,
        ]
    )
    var buttonVariant: DSButtonVariant = .filled

    @FigmaEnum(
        "size",
        mapping: [
            "small": DSButtonSize.small,
            "medium": DSButtonSize.medium,
            "large": DSButtonSize.large,
        ]
    )
    var size: DSButtonSize = .medium

    @FigmaString("Label")
    var title: String = "Button"

    @FigmaBoolean("Show Icon", hideDefault: true)
    var showIcon: Bool = false

    var body: some View {
        DSButton(
            title: self.title,
            icon: self.showIcon ? "star.fill" : nil,
            variant: self.buttonVariant,
            size: self.size
        ) {
            // action
        }
    }
}

#Preview { DSButton_connection() }
