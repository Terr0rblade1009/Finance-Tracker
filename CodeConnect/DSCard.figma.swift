import SwiftUI
import Figma

struct DSCard_connection: FigmaConnect {
    let component = DSCard<AnyView>.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=22-11"

    @FigmaEnum(
        "variant",
        mapping: [
            "elevated": DSCardVariant.elevated,
            "filled": DSCardVariant.filled,
            "outlined": DSCardVariant.outlined,
        ]
    )
    var cardVariant: DSCardVariant = .filled

    @FigmaChildren(layers: ["Content"])
    var content: AnyView? = nil

    var body: some View {
        DSCard(variant: self.cardVariant) {
            self.content
        }
    }
}

#Preview { DSCard_connection() }
