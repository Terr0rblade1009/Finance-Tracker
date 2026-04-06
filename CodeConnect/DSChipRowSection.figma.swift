import SwiftUI
import Figma

struct DSChipRowSection_connection: FigmaConnect {
    let component = DSChipRowSection.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=226-3"

    var body: some View {
        DSChipRowSection(
            title: "账户",
            chips: [
                .init(id: UUID(), label: "现金"),
                .init(id: UUID(), label: "支付宝"),
                .init(id: UUID(), label: "微信"),
                .init(id: UUID(), label: "银行卡"),
            ],
            selectedId: nil
        ) { _ in }
    }
}

#Preview { DSChipRowSection_connection() }
