import SwiftUI

struct ImportHubView: View {
    @State private var showCamera = false
    @State private var showFile = false
    @State private var showVoice = false
    @State private var showWeChat = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: M3Spacing.lg) {
                    headerCard

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: M3Spacing.md) {
                        DSImportCard(
                            icon: "camera.fill",
                            title: L("拍照记账"),
                            subtitle: L("拍摄收据自动识别"),
                            color: M3Color.Light.primary
                        ) {
                            showCamera = true
                        }

                        DSImportCard(
                            icon: "mic.fill",
                            title: L("语音记账"),
                            subtitle: L("说出消费信息"),
                            color: Color(hex: "EF5350")
                        ) {
                            showVoice = true
                        }

                        DSImportCard(
                            icon: "message.fill",
                            title: L("微信导入"),
                            subtitle: L("从微信对话导入"),
                            color: Color(hex: "07C160")
                        ) {
                            showWeChat = true
                        }

                        DSImportCard(
                            icon: "doc.fill",
                            title: L("文件导入"),
                            subtitle: L("PDF/CSV/图片"),
                            color: Color(hex: "42A5F5")
                        ) {
                            showFile = true
                        }

                        DSImportCard(
                            icon: "photo.fill",
                            title: L("截图记账"),
                            subtitle: L("识别截图中的账单"),
                            color: Color(hex: "BA68C8")
                        ) {
                            showCamera = true
                        }

                        DSImportCard(
                            icon: "doc.text.viewfinder",
                            title: L("OCR识别"),
                            subtitle: L("智能文字识别"),
                            color: Color(hex: "FF8A65")
                        ) {
                            showCamera = true
                        }
                    }
                }
                .padding(M3Spacing.base)
            }
            .background(M3Color.Adaptive.surface)
            .navigationTitle(L("导入"))
            .sheet(isPresented: $showCamera) { CameraReceiptView() }
            .sheet(isPresented: $showFile) { FileImportView() }
            .sheet(isPresented: $showVoice) { VoiceInputView() }
            .sheet(isPresented: $showWeChat) { WeChatImportView() }
        }
    }

    private var headerCard: some View {
        DSCard(variant: .filled) {
            VStack(spacing: M3Spacing.md) {
                Image(systemName: "wand.and.stars")
                    .font(.system(size: 36))
                    .foregroundColor(M3Color.Adaptive.primary)
                Text(L("智能导入"))
                    .font(M3Typography.titleLarge)
                    .foregroundColor(M3Color.Adaptive.onSurface)
                Text(L("多种方式快速记录你的消费"))
                    .font(M3Typography.bodyMedium)
                    .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
            }
            .padding(M3Spacing.xl)
            .frame(maxWidth: .infinity)
        }
    }
}
