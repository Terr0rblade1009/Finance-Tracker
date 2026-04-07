import Foundation

#if os(iOS)
import UIKit
import Vision

actor OCRService {
    static let shared = OCRService()

    func recognizeText(from image: UIImage) async throws -> String {
        guard let cgImage = image.cgImage else {
            throw OCRError.invalidImage
        }

        return try await withCheckedThrowingContinuation { continuation in
            let request = VNRecognizeTextRequest { request, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let observations = request.results as? [VNRecognizedTextObservation] else {
                    continuation.resume(returning: "")
                    return
                }

                let text = observations.compactMap { observation in
                    observation.topCandidates(1).first?.string
                }.joined(separator: "\n")

                continuation.resume(returning: text)
            }

            request.recognitionLevel = .accurate
            request.recognitionLanguages = ["zh-Hans", "zh-Hant", "en"]
            request.usesLanguageCorrection = true

            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            do {
                try handler.perform([request])
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }

    func extractAmountFromReceipt(_ image: UIImage) async throws -> (amount: Decimal?, items: [ReceiptItem]) {
        let text = try await recognizeText(from: image)
        return parseReceiptText(text)
    }

    private func parseReceiptText(_ text: String) -> (amount: Decimal?, items: [ReceiptItem]) {
        let lines = text.components(separatedBy: .newlines)
        var items: [ReceiptItem] = []
        var totalAmount: Decimal?

        let totalPatterns = [
            #"合计[：:]\s*[¥￥$]?\s*(\d+\.?\d{0,2})"#,
            #"总[计额][：:]\s*[¥￥$]?\s*(\d+\.?\d{0,2})"#,
            #"[Tt]otal[：:]\s*[¥￥$]?\s*(\d+\.?\d{0,2})"#,
            #"实付[：:]\s*[¥￥$]?\s*(\d+\.?\d{0,2})"#,
        ]

        for line in lines {
            for pattern in totalPatterns {
                if let regex = try? NSRegularExpression(pattern: pattern),
                   let match = regex.firstMatch(in: line, range: NSRange(line.startIndex..., in: line)),
                   let range = Range(match.range(at: 1), in: line) {
                    totalAmount = Decimal(string: String(line[range]))
                }
            }

            let itemPattern = #"(.+?)\s+[¥￥$]?\s*(\d+\.?\d{0,2})"#
            if let regex = try? NSRegularExpression(pattern: itemPattern),
               let match = regex.firstMatch(in: line, range: NSRange(line.startIndex..., in: line)),
               let nameRange = Range(match.range(at: 1), in: line),
               let amountRange = Range(match.range(at: 2), in: line),
               let amount = Decimal(string: String(line[amountRange])) {
                let name = String(line[nameRange]).trimmingCharacters(in: .whitespaces)
                items.append(ReceiptItem(name: name, amount: amount))
            }
        }

        return (totalAmount, items)
    }

    enum OCRError: LocalizedError {
        case invalidImage
        case recognitionFailed

        var errorDescription: String? {
            switch self {
            case .invalidImage: return L("无法处理图片")
            case .recognitionFailed: return L("文字识别失败")
            }
        }
    }
}
#endif

struct ReceiptItem: Identifiable {
    let id = UUID()
    let name: String
    let amount: Decimal
}
