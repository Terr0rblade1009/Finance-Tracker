import SwiftUI
#if canImport(UIKit)
import UIKit
#endif
#if canImport(AVFoundation)
import AVFoundation
#endif

struct CameraReceiptView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var capturedImage: UIImage?
    @State private var recognizedText = ""
    @State private var recognizedAmount: Decimal?
    @State private var isProcessing = false
    @State private var showImagePicker = false
    @State private var showCamera = false
    @State private var receiptItems: [ReceiptItem] = []
    @State private var showExpenseInput = false
    @State private var merchantName: String?
    @State private var receiptSummary: String?
    @State private var usedAI = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: M3Spacing.xl) {
                    captureSection
                    if let image = capturedImage {
                        imagePreview(image)
                    }
                    if isProcessing {
                        processingIndicator
                    }
                    if !recognizedText.isEmpty {
                        resultSection
                    }
                }
                .padding(M3Spacing.base)
            }
            .background(M3Color.Adaptive.surface)
            .navigationTitle(L("拍照记账"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(L("关闭")) { dismiss() }
                }
            }
            .sheet(isPresented: $showCamera) {
                ImagePickerView(image: $capturedImage, sourceType: .camera)
                    .ignoresSafeArea()
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePickerView(image: $capturedImage, sourceType: .photoLibrary)
                    .ignoresSafeArea()
            }
            .onChange(of: capturedImage) { _, newImage in
                if let image = newImage {
                    processImage(image)
                }
            }
            .sheet(isPresented: $showExpenseInput) {
                ExpenseInputView(
                    prefillAmount: ocrPrefillAmount,
                    prefillNote: ocrPrefillNote,
                    prefillReceiptImageData: capturedImage?.jpegData(compressionQuality: 0.6),
                    prefillSourceType: .ocr
                )
            }
        }
    }

    private var captureSection: some View {
        VStack(spacing: M3Spacing.base) {
            HStack(spacing: M3Spacing.base) {
                Button {
                    showCamera = true
                } label: {
                    VStack(spacing: M3Spacing.md) {
                        Image(systemName: "camera.fill")
                            .font(.system(size: M3IconSize.large))
                            .foregroundColor(M3Color.Adaptive.primary)
                        Text(L("拍摄收据"))
                            .font(M3Typography.labelLarge)
                            .foregroundColor(M3Color.Adaptive.onSurface)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, M3Spacing.xxl)
                    .background(M3Color.Adaptive.primaryContainer.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: M3Radius.large))
                }

                Button {
                    showImagePicker = true
                } label: {
                    VStack(spacing: M3Spacing.md) {
                        Image(systemName: "photo.on.rectangle")
                            .font(.system(size: M3IconSize.large))
                            .foregroundColor(M3Color.Adaptive.tertiary)
                        Text(L("选择图片"))
                            .font(M3Typography.labelLarge)
                            .foregroundColor(M3Color.Adaptive.onSurface)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, M3Spacing.xxl)
                    .background(M3Color.Adaptive.tertiaryContainer.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: M3Radius.large))
                }
            }
        }
    }

    private func imagePreview(_ image: UIImage) -> some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxHeight: 240)
            .clipShape(RoundedRectangle(cornerRadius: M3Radius.large))
            .m3Shadow(M3Elevation.level1)
    }

    private var processingIndicator: some View {
        VStack(spacing: M3Spacing.md) {
            ProgressView()
                .scaleEffect(1.2)
            Text(usedAI ? L("AI 识别中...") : L("正在识别..."))
                .font(M3Typography.bodyMedium)
                .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
        }
        .padding(M3Spacing.xl)
    }

    private var resultSection: some View {
        VStack(alignment: .leading, spacing: M3Spacing.md) {
            HStack {
                Text(L("识别结果"))
                    .font(M3Typography.titleMedium)
                    .foregroundColor(M3Color.Adaptive.onSurface)
                if usedAI {
                    Text("GPT-4o")
                        .font(M3Typography.labelSmall)
                        .foregroundColor(.white)
                        .padding(.horizontal, M3Spacing.sm)
                        .padding(.vertical, 2)
                        .background(Color(hex: "10A37F"))
                        .clipShape(Capsule())
                }
            }

            if let merchant = merchantName {
                HStack(spacing: M3Spacing.sm) {
                    Image(systemName: "storefront.fill")
                        .font(M3Typography.bodySmall)
                        .foregroundColor(M3Color.Adaptive.tertiary)
                    Text(merchant)
                        .font(M3Typography.bodyMedium)
                        .foregroundColor(M3Color.Adaptive.onSurface)
                }
            }

            if let amount = recognizedAmount {
                DSCard(variant: .outlined) {
                    HStack {
                        Text(L("总金额"))
                            .font(M3Typography.bodyLarge)
                            .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                        Spacer()
                        Text(amount.currencyString)
                            .font(M3Typography.headlineSmall)
                            .foregroundColor(M3Color.Adaptive.primary)
                    }
                    .padding(M3Spacing.base)
                }
            }

            if !receiptItems.isEmpty {
                ForEach(receiptItems) { item in
                    HStack {
                        Text(item.name)
                            .font(M3Typography.bodyMedium)
                            .foregroundColor(M3Color.Adaptive.onSurface)
                        Spacer()
                        Text(item.amount.currencyString)
                            .font(M3Typography.bodyMedium)
                            .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                    }
                    .padding(.vertical, M3Spacing.xs)
                }
            }

            if let summary = receiptSummary, !summary.isEmpty {
                DSCard(variant: .filled) {
                    Text(summary)
                        .font(M3Typography.bodySmall)
                        .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                        .padding(M3Spacing.md)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            } else if !recognizedText.isEmpty {
                DSCard(variant: .filled) {
                    Text(recognizedText)
                        .font(M3Typography.bodySmall)
                        .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                        .padding(M3Spacing.md)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            DSButton(
                title: L("导入到记账"),
                icon: "square.and.arrow.down",
                variant: .filled,
                size: .large,
                isFullWidth: true
            ) {
                showExpenseInput = true
            }
        }
    }

    private var ocrPrefillAmount: Decimal {
        if let total = recognizedAmount { return total }
        if !receiptItems.isEmpty {
            return receiptItems.reduce(Decimal.zero) { $0 + $1.amount }
        }
        return 0
    }

    private var ocrPrefillNote: String {
        var parts: [String] = []
        if let merchant = merchantName { parts.append(merchant) }
        let itemNames = receiptItems.map(\.name).joined(separator: ", ")
        if !itemNames.isEmpty { parts.append(itemNames) }
        if parts.isEmpty, let summary = receiptSummary { parts.append(summary) }
        return parts.joined(separator: " - ")
    }

    private func processImage(_ image: UIImage) {
        isProcessing = true
        recognizedText = ""
        recognizedAmount = nil
        receiptItems = []
        merchantName = nil
        receiptSummary = nil

        Task {
            let hasKey = await OpenAIOCRService.shared.hasAPIKey
            await MainActor.run { usedAI = hasKey }

            if hasKey {
                await processWithOpenAI(image)
            } else {
                await processWithLocalOCR(image)
            }
        }
    }

    private func processWithOpenAI(_ image: UIImage) async {
        do {
            let result = try await OpenAIOCRService.shared.extractReceiptInfo(from: image)
            await MainActor.run {
                recognizedAmount = result.total
                receiptItems = result.items
                merchantName = result.merchant
                receiptSummary = result.summary
                recognizedText = result.summary ?? result.items.map { "\($0.name): \($0.amount.currencyString)" }.joined(separator: "\n")
                isProcessing = false
            }
        } catch {
            await MainActor.run {
                recognizedText = L("AI识别失败") + ": \(error.localizedDescription)"
                isProcessing = false
            }
        }
    }

    private func processWithLocalOCR(_ image: UIImage) async {
        do {
            let result = try await OCRService.shared.extractAmountFromReceipt(image)
            var text = result.items.map { "\($0.name): \($0.amount.currencyString)" }.joined(separator: "\n")
            if text.isEmpty {
                text = (try? await OCRService.shared.recognizeText(from: image)) ?? L("无法识别文字")
            }
            await MainActor.run {
                recognizedAmount = result.amount
                receiptItems = result.items
                recognizedText = text
                isProcessing = false
            }
        } catch {
            await MainActor.run {
                recognizedText = L("识别失败") + ": \(error.localizedDescription)"
                isProcessing = false
            }
        }
    }

}

// MARK: - Image Picker

#if os(iOS)
struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePickerView

        init(_ parent: ImagePickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}
#endif
