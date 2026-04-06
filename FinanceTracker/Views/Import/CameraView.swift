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
    @State private var recognizedAmount: Double?
    @State private var isProcessing = false
    @State private var showImagePicker = false
    @State private var showCamera = false
    @State private var receiptItems: [ReceiptItem] = []

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
                            .font(.system(size: 32))
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
                            .font(.system(size: 32))
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
            Text(L("正在识别..."))
                .font(M3Typography.bodyMedium)
                .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
        }
        .padding(M3Spacing.xl)
    }

    private var resultSection: some View {
        VStack(alignment: .leading, spacing: M3Spacing.md) {
            Text(L("识别结果"))
                .font(M3Typography.titleMedium)
                .foregroundColor(M3Color.Adaptive.onSurface)

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

            DSCard(variant: .filled) {
                Text(recognizedText)
                    .font(M3Typography.bodySmall)
                    .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                    .padding(M3Spacing.md)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            if recognizedAmount != nil {
                DSButton(
                    title: L("记录此笔支出"),
                    icon: "checkmark",
                    variant: .filled,
                    size: .large,
                    isFullWidth: true
                ) {
                    dismiss()
                }
            }
        }
    }

    private func processImage(_ image: UIImage) {
        isProcessing = true
        Task {
            do {
                let result = try await OCRService.shared.extractAmountFromReceipt(image)
                var text = result.items.map { "\($0.name): $\($0.amount)" }.joined(separator: "\n")
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
