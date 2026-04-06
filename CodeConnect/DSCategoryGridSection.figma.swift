import SwiftUI
import Figma

struct DSCategoryGridSection_connection: FigmaConnect {
    let component = DSCategoryGridSection.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=225-3"

    var body: some View {
        DSCategoryGridSection(
            title: "分类",
            categories: [
                .init(id: UUID(), icon: "fork.knife", name: "餐饮", color: .orange),
                .init(id: UUID(), icon: "cart.fill", name: "购物", color: .blue),
            ],
            selectedId: nil
        ) { _ in }
    }
}

#Preview { DSCategoryGridSection_connection() }
