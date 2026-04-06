import SwiftUI

struct DSSectionHeader: View {
    let title: String
    var trailing: String? = nil
    var trailingAction: (() -> Void)? = nil

    var body: some View {
        HStack {
            Text(title)
                .font(M3Typography.labelLarge)
                .foregroundColor(M3Color.Adaptive.onSurfaceVariant)

            Spacer()

            if let trailing, let trailingAction {
                Button(action: trailingAction) {
                    Text(trailing)
                        .font(M3Typography.labelMedium)
                        .foregroundColor(M3Color.Adaptive.primary)
                }
            }
        }
    }
}
