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
        (.manual, "pencil.line", L("手动输入"), L("选分类、填金额、快速记一笔"), M3Color.Adaptive.primary),
        (.camera, "camera.fill", L("拍照识别"), L("拍收据或截图，自动识别金额"), M3Color.Adaptive.tertiary),
        (.voice, "mic.fill", L("语音记账"), L("说出金额和用途，AI 帮你记"), M3Color.Adaptive.secondary),
    ]

    var body: some View {
        DSBottomSheet(isPresented: $isPresented) {
            VStack(spacing: M3Spacing.sm) {
                ForEach(methods, id: \.0) { method, icon, title, subtitle, color in
                    Button {
                        withAnimation(.spring(response: 0.25)) {
                            isPresented = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                            onSelect(method)
                        }
                    } label: {
                        HStack(spacing: M3Spacing.base) {
                            ZStack {
                                RoundedRectangle(cornerRadius: M3Radius.medium)
                                    .fill(color.opacity(0.12))
                                    .frame(width: 48, height: 48)
                                Image(systemName: icon)
                                    .font(.system(size: 20))
                                    .foregroundColor(color)
                            }

                            VStack(alignment: .leading, spacing: 2) {
                                Text(title)
                                    .font(M3Typography.titleSmall)
                                    .foregroundColor(M3Color.Adaptive.onSurface)
                                Text(subtitle)
                                    .font(M3Typography.bodySmall)
                                    .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                            }

                            Spacer()

                            Image(systemName: "chevron.right")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(M3Color.Adaptive.outline)
                        }
                        .padding(M3Spacing.md)
                        .background(M3Color.Adaptive.surfaceContainerHigh)
                        .clipShape(RoundedRectangle(cornerRadius: M3Radius.medium))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, M3Spacing.base)
            .padding(.bottom, M3Spacing.xxl + M3Spacing.base)
        }
    }
}
