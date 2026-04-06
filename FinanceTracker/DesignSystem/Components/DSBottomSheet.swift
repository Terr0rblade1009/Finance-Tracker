import SwiftUI

struct DSBottomSheet<Content: View>: View {
    @Binding var isPresented: Bool
    let content: () -> Content

    var body: some View {
        ZStack(alignment: .bottom) {
            if isPresented {
                Color.black.opacity(0.32)
                    .ignoresSafeArea()
                    .onTapGesture { withAnimation(.spring(response: 0.35)) { isPresented = false } }
                    .transition(.opacity)

                VStack(spacing: 0) {
                    Capsule()
                        .fill(M3Color.Adaptive.onSurfaceVariant.opacity(0.4))
                        .frame(width: 32, height: 4)
                        .padding(.top, M3Spacing.sm)
                        .padding(.bottom, M3Spacing.base)

                    content()
                }
                .frame(maxWidth: .infinity)
                .background(M3Color.Adaptive.surfaceContainerLow)
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: M3Radius.extraLarge,
                        topTrailingRadius: M3Radius.extraLarge
                    )
                )
                .transition(.move(edge: .bottom))
            }
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.86), value: isPresented)
        .ignoresSafeArea()
    }
}
