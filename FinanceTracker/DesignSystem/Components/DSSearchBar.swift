import SwiftUI

struct DSSearchBar: View {
    @Binding var text: String
    var placeholder: String = L("搜索")
    @FocusState private var isFocused: Bool

    var body: some View {
        HStack(spacing: M3Spacing.md) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 20))
                .foregroundColor(M3Color.Adaptive.onSurfaceVariant)

            TextField(placeholder, text: $text)
                .font(M3Typography.bodyLarge)
                .foregroundColor(M3Color.Adaptive.onSurface)
                .focused($isFocused)

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 18))
                        .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                }
            }
        }
        .padding(.horizontal, M3Spacing.base)
        .padding(.vertical, M3Spacing.md)
        .background(M3Color.Adaptive.surfaceContainerHigh)
        .clipShape(RoundedRectangle(cornerRadius: M3Radius.full))
    }
}
