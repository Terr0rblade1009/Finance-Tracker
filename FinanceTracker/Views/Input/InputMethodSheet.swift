import SwiftUI

enum InputMethod: Identifiable {
    case manual
    case camera
    case voice

    var id: Self { self }
}

struct InputMethodSheet: View {
    @Binding var isPresented: Bool
    var onSelect: (InputMethod) -> Void

    private let methods: [(InputMethod, String, String, String, Color)] = [
        (.manual, "pencil.line", L("手动输入"), L("输入金额、分类和备注"), M3Color.Adaptive.primary),
        (.camera, "camera.fill", L("拍照记账"), L("拍摄票据自动识别"), M3Color.Adaptive.tertiary),
        (.voice, "mic.fill", L("语音记账"), L("说出消费内容自动记录"), M3Color.Adaptive.secondary),
    ]

    var body: some View {
        DSBottomSheet(isPresented: $isPresented) {
            VStack(spacing: M3Spacing.md) {
                ForEach(methods, id: \.0) { method, icon, title, subtitle, color in
                    Button {
                        withAnimation(.spring(response: 0.25)) {
                            isPresented = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                            onSelect(method)
                        }
                    } label: {
                        DSMethodCard(
                            iconColor: color,
                            icon: icon,
                            title: title,
                            subtitle: subtitle
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, M3Spacing.base)
            .padding(.bottom, M3Spacing.xxl + M3Spacing.base)
        }
    }
}
