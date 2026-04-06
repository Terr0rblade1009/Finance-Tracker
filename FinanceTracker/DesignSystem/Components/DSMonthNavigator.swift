import SwiftUI

struct DSMonthNavigator<Trailing: View>: View {
    @Binding var currentDate: Date
    var style: Style = .compact
    @ViewBuilder var trailing: () -> Trailing

    enum Style {
        case compact
        case prominent
    }

    private var calendar: Calendar { Calendar.current }

    private var monthLabel: String {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy/MM"
        return fmt.string(from: currentDate)
    }

    var body: some View {
        HStack {
            Button {
                withAnimation { changeMonth(by: -1) }
            } label: {
                switch style {
                case .compact:
                    Image(systemName: "chevron.left")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                        .frame(width: 32, height: 32)
                        .background(M3Color.Adaptive.surfaceContainerHigh)
                        .clipShape(Circle())
                case .prominent:
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(M3Color.Adaptive.primary)
                }
            }

            if style == .compact {
                Text(monthLabel)
                    .font(M3Typography.titleMedium)
                    .foregroundColor(M3Color.Adaptive.onSurface)
                    .padding(.horizontal, M3Spacing.sm)
            } else {
                Spacer()
                Text(monthLabel)
                    .font(M3Typography.titleLarge)
                    .foregroundColor(M3Color.Adaptive.onSurface)
                Spacer()
            }

            Button {
                withAnimation { changeMonth(by: 1) }
            } label: {
                switch style {
                case .compact:
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(M3Color.Adaptive.onSurfaceVariant)
                        .frame(width: 32, height: 32)
                        .background(M3Color.Adaptive.surfaceContainerHigh)
                        .clipShape(Circle())
                case .prominent:
                    Image(systemName: "chevron.right.circle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(M3Color.Adaptive.primary)
                }
            }

            if style == .compact {
                Spacer()
                trailing()
            }
        }
    }

    private func changeMonth(by value: Int) {
        if let newDate = calendar.date(byAdding: .month, value: value, to: currentDate) {
            currentDate = newDate
        }
    }
}

extension DSMonthNavigator where Trailing == EmptyView {
    init(currentDate: Binding<Date>, style: Style = .compact) {
        self._currentDate = currentDate
        self.style = style
        self.trailing = { EmptyView() }
    }
}
