import SwiftUI
import Figma

struct DSChip_connection: FigmaConnect {
    let component = DSChip.self
    let figmaNodeUrl = "https://www.figma.com/design/bRtV6gACFbALKiKHXtNsBD/FinanceTracker?node-id=25-14"

    @FigmaEnum(
        "variant",
        mapping: [
            "filter": DSChipVariant.filter,
            "suggestion": DSChipVariant.suggestion,
            "input": DSChipVariant.input,
        ]
    )
    var chipVariant: DSChipVariant = .filter

    @FigmaEnum(
        "selected",
        mapping: [
            "true": true,
            "false": false,
        ]
    )
    var isSelected: Bool = false

    @FigmaString("Label")
    var label: String = "Chip"

    @FigmaBoolean("Show Icon", hideDefault: true)
    var showIcon: Bool = false

    var body: some View {
        DSChip(
            label: self.label,
            icon: self.showIcon ? "tag" : nil,
            variant: self.chipVariant,
            isSelected: self.isSelected
        )
    }
}

#Preview { DSChip_connection() }
