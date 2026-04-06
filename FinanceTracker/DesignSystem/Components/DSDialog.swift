import SwiftUI

struct DSDialog: View {
    @Binding var isPresented: Bool
    let title: String
    let message: String
    var cancelLabel: String = L("取消")
    var confirmLabel: String = L("删除")
    var confirmRole: ButtonRole? = .destructive
    var onConfirm: () -> Void

    var body: some View {
        ZStack {
            if isPresented {
                M3Color.scrim
                    .ignoresSafeArea()
                    .onTapGesture { withAnimation(.spring(response: 0.3)) { isPresented = false } }
                    .transition(.opacity)

                VStack(alignment: .leading, spacing: M3Spacing.base) {
                    Text(title)
                        .font(M3Typography.titleLarge)
                        .fontWeight(.semibold)
                        .foregroundColor(M3Color.Adaptive.onSurface)

                    Text(message)
                        .font(M3Typography.bodyMedium)
                        .foregroundColor(M3Color.Adaptive.onSurfaceVariant)

                    HStack(spacing: M3Spacing.sm) {
                        Spacer()
                        DSButton(title: cancelLabel, variant: .text, size: .medium) {
                            withAnimation(.spring(response: 0.3)) { isPresented = false }
                        }
                        DSButton(title: confirmLabel, variant: .filled, size: .medium) {
                            onConfirm()
                            withAnimation(.spring(response: 0.3)) { isPresented = false }
                        }
                    }
                }
                .padding(M3Spacing.xl)
                .frame(width: 310)
                .background(M3Color.Adaptive.surface)
                .clipShape(RoundedRectangle(cornerRadius: M3Radius.extraLarge))
                .m3Shadow(M3Elevation.level3)
                .transition(.scale(scale: 0.9).combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.85), value: isPresented)
        .ignoresSafeArea()
    }
}
