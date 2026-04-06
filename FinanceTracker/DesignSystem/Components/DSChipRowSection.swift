import SwiftUI

struct DSChipRowSection: View {
    let title: String
    let chips: [ChipItem]
    var selectedId: UUID? = nil
    var scrollable: Bool = true
    var onSelect: ((UUID) -> Void)? = nil

    struct ChipItem: Identifiable {
        let id: UUID
        let label: String
        var icon: String? = nil
        var color: Color? = nil
    }

    var body: some View {
        VStack(alignment: .leading, spacing: M3Spacing.md) {
            DSSectionHeader(title: title)

            if scrollable {
                ScrollView(.horizontal, showsIndicators: false) {
                    chipRow
                }
            } else {
                chipRow
            }
        }
    }

    private var chipRow: some View {
        HStack(spacing: M3Spacing.sm) {
            ForEach(chips) { chip in
                DSChip(
                    label: chip.label,
                    icon: chip.icon,
                    isSelected: selectedId == chip.id,
                    color: chip.color
                ) {
                    onSelect?(chip.id)
                }
            }
            if !scrollable {
                Spacer()
            }
        }
    }
}
