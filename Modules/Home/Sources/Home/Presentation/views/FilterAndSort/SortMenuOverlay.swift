import SwiftUI

struct SortButtonAnchorKey: PreferenceKey {
    static var defaultValue: Anchor<CGRect>?
    static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = nextValue() ?? value
    }
}

private struct SortRow<Option: Hashable>: View {
    let option: Option
    let title: String
    let systemIcon: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(isSelected ? Color.appPrimaryOrange : Color.appPrimaryOrange.opacity(0.10))
                        .frame(width: 30, height: 30)
                    Image(systemName: systemIcon)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(isSelected ? .white : .appPrimaryOrange)
                }

                Text(title)
                    .font(.system(size: 15, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(.appTextPrimary)

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.appPrimaryOrange)
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .padding(.vertical, 11)
            .padding(.horizontal, 14)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(isSelected ? Color.appPrimaryOrange.opacity(0.08) : Color.clear)
            )
        }
        .buttonStyle(.plain)
    }
}

struct FloatingSortCard<Option: Hashable>: View {
    let options: [Option]
    @Binding var selected: Option
    let title: (Option) -> String
    let icon: (Option) -> String
    let onPick: (Option) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Order By")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.appTextTertiary)
                .padding(.horizontal, 16)
                .padding(.top, 14)
                .padding(.bottom, 6)

            VStack(spacing: 2) {
                ForEach(options, id: \.self) { option in
                    SortRow(
                        option: option,
                        title: title(option),
                        systemIcon: icon(option),
                        isSelected: option == selected
                    ) {
                        let haptic = UIImpactFeedbackGenerator(style: .light)
                        haptic.impactOccurred()
                        withAnimation(.spring(response: 0.32, dampingFraction: 0.78)) {
                            selected = option
                        }
                        onPick(option)
                    }
                }
            }
            .padding(.horizontal, 6)
            .padding(.bottom, 8)
        }
        .frame(width: 230)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.systemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.black.opacity(0.06), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.18), radius: 26, x: 0, y: 14)
    }
}

struct SortMenuOverlay<Option: Hashable>: View {
    @Binding var isPresented: Bool
    let anchor: Anchor<CGRect>?
    let options: [Option]
    @Binding var selected: Option
    let title: (Option) -> String
    let icon: (Option) -> String
    var onPick: (() -> Void)? = nil

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topLeading) {
                if isPresented {
                    Color.black.opacity(0.22)
                        .ignoresSafeArea()
                        .transition(.opacity)
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 0.18)) { isPresented = false }
                        }

                    if let anchor {
                        let rect = proxy[anchor]
                        FloatingSortCard(
                            options: options,
                            selected: $selected,
                            title: title,
                            icon: icon,
                            onPick: { _ in
                                onPick?()
                                withAnimation(.spring(response: 0.32, dampingFraction: 0.8).delay(0.05)) {
                                    isPresented = false
                                }
                            }
                        )
                        .scaleEffect(isPresented ? 1 : 0.85, anchor: .topTrailing)
                        .opacity(isPresented ? 1 : 0)
                        .position(
                            x: max(rect.maxX - 115, 130),
                            y: rect.maxY + 8 + 140
                        )
                    }
                }
            }
            .animation(.spring(response: 0.4, dampingFraction: 0.82), value: isPresented)
        }
        .allowsHitTesting(isPresented)
    }
}
