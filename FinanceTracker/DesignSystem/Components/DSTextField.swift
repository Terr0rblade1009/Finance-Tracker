import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

struct DSTextField: View {
    let label: String
    @Binding var text: String
    var icon: String?
    var isSecure: Bool = false
    #if canImport(UIKit)
    var keyboardType: UIKeyboardType = .default
    #endif
    var errorMessage: String?
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: M3Spacing.xs) {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: M3Radius.extraSmall)
                    .fill(M3Color.Adaptive.surfaceContainerHighest)
                    .frame(height: 56)
                    .overlay(
                        RoundedRectangle(cornerRadius: M3Radius.extraSmall)
                            .strokeBorder(
                                borderColor,
                                lineWidth: isFocused ? 2 : 1
                            )
                    )

                HStack(spacing: M3Spacing.md) {
                    if let icon {
                        Image(systemName: icon)
                            .font(.system(size: M3IconSize.medium))
                            .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                    }

                    VStack(alignment: .leading, spacing: M3Spacing.xxs) {
                        if !text.isEmpty || isFocused {
                            Text(label)
                                .font(M3Typography.bodySmall)
                                .foregroundColor(isFocused ? M3Color.Adaptive.primary : M3Color.Adaptive.onSurfaceVariant)
                        }

                        if isSecure {
                            SecureField(text.isEmpty && !isFocused ? label : "", text: $text)
                                .font(M3Typography.bodyLarge)
                                .foregroundColor(M3Color.Adaptive.onSurface)
                                .focused($isFocused)
                        } else {
                            TextField(text.isEmpty && !isFocused ? label : "", text: $text)
                                .font(M3Typography.bodyLarge)
                                .foregroundColor(M3Color.Adaptive.onSurface)
                                #if canImport(UIKit)
                                .keyboardType(keyboardType)
                                #endif
                                .focused($isFocused)
                        }
                    }
                }
                .padding(.horizontal, M3Spacing.base)
            }

            if let errorMessage {
                Text(errorMessage)
                    .font(M3Typography.bodySmall)
                    .foregroundColor(M3Color.Adaptive.error)
                    .padding(.leading, M3Spacing.base)
            }
        }
    }

    private var borderColor: Color {
        if errorMessage != nil { return M3Color.Adaptive.error }
        return isFocused ? M3Color.Adaptive.primary : M3Color.Adaptive.outline
    }
}
