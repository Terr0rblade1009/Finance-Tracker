import SwiftUI

struct DSNumericKeypad: View {
    @Binding var value: String
    var onConfirm: () -> Void

    private let keys: [[KeypadKey]] = [
        [.digit("1"), .digit("2"), .digit("3")],
        [.digit("4"), .digit("5"), .digit("6")],
        [.digit("7"), .digit("8"), .digit("9")],
        [.dot, .digit("0"), .delete]
    ]

    var body: some View {
        VStack(spacing: M3Spacing.sm) {
            ForEach(keys, id: \.self) { row in
                HStack(spacing: M3Spacing.sm) {
                    ForEach(row, id: \.self) { key in
                        KeypadButton(key: key) {
                            handleKeyPress(key)
                        }
                    }
                }
            }

            DSButton(
                title: L("确认"),
                icon: "checkmark",
                variant: .filled,
                size: .large,
                isFullWidth: true
            ) {
                onConfirm()
            }
            .padding(.top, M3Spacing.sm)
        }
        .padding(M3Spacing.base)
    }

    private func handleKeyPress(_ key: KeypadKey) {
        switch key {
        case .digit(let d):
            if value == "0" && d != "0" {
                value = d
            } else if value.contains(".") {
                let parts = value.split(separator: ".")
                if parts.count < 2 || parts[1].count < 2 {
                    value += d
                }
            } else if value.count < 10 {
                value += d
            }
        case .dot:
            if !value.contains(".") {
                value += "."
            }
        case .delete:
            if value.count > 1 {
                value.removeLast()
            } else {
                value = "0"
            }
        }
    }
}

enum KeypadKey: Hashable {
    case digit(String)
    case dot
    case delete
}

private struct KeypadButton: View {
    let key: KeypadKey
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: M3Radius.medium)
                    .fill(M3Color.Adaptive.surfaceContainerHigh)

                switch key {
                case .digit(let d):
                    Text(d)
                        .font(M3Typography.headlineSmall)
                        .foregroundColor(M3Color.Adaptive.onSurface)
                case .dot:
                    Text(".")
                        .font(M3Typography.headlineSmall)
                        .foregroundColor(M3Color.Adaptive.onSurface)
                case .delete:
                    Image(systemName: "delete.left")
                        .font(.system(size: 22))
                        .foregroundColor(M3Color.Adaptive.onSurface)
                }
            }
            .frame(height: 56)
        }
        .buttonStyle(KeypadButtonStyle())
    }
}

private struct KeypadButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
