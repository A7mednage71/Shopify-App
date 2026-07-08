import SwiftUI
import Common
struct OnboardingView: View {
    private let items: [OnboardingItem]
    private let onFinish: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var selectedIndex = 0
    @State private var isFloating = false

    init(
        items: [OnboardingItem] = OnboardingItem.defaults,
        onFinish: @escaping () -> Void
    ) {
        self.items = items
        self.onFinish = onFinish
    }

    var body: some View {
        ZStack {
            OnboardingPalette.pageBackground
                .ignoresSafeArea()

            VStack(spacing: 0) {
                skipButton

                pages

                VStack(spacing: 24) {
                    OnboardingProgressView(
                        currentIndex: selectedIndex,
                        totalCount: items.count
                    )

                    OnboardingPrimaryButton(
                        title: selectedIndex == items.count - 1 ? L10n.Onboarding.startShopping : L10n.Onboarding.next,
                        action: handlePrimaryAction
                    )
                    .padding(.horizontal, 24)
                }
                .padding(.top, 12)
                .padding(.bottom, 18)
            }
        }
        .onAppear {
            startFloatingAnimation()
        }
        .onChange(of: selectedIndex) { _ in
            startFloatingAnimation()
        }
    }

    private var skipButton: some View {
        HStack {
            Spacer()

            Button(L10n.Onboarding.skip, action: onFinish)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(OnboardingPalette.textSecondary)
                .padding(.horizontal, 24)
                .padding(.top, 18)
                .padding(.bottom, 6)
                .accessibilityLabel(L10n.Onboarding.skipAccessibilityLabel)
        }
    }

    @ViewBuilder
    private var pages: some View {
        TabView(selection: $selectedIndex) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                OnboardingPageView(
                    item: item,
                    isActive: selectedIndex == index,
                    isFloating: isFloating && selectedIndex == index,
                    reduceMotion: reduceMotion
                )
                .tag(index)
                .padding(.horizontal, 24)
            }
        }
        #if os(iOS)
        .tabViewStyle(.page(indexDisplayMode: .never))
        #endif
        .animation(.easeInOut(duration: 0.28), value: selectedIndex)
    }

    private func handlePrimaryAction() {
        guard selectedIndex < items.count - 1 else {
            onFinish()
            return
        }

        withAnimation(.spring(response: 0.42, dampingFraction: 0.84)) {
            selectedIndex += 1
        }
    }

    private func startFloatingAnimation() {
        guard !reduceMotion else {
            isFloating = false
            return
        }

        isFloating = false

        withAnimation(
            .easeInOut(duration: 1.7)
                .repeatForever(autoreverses: true)
        ) {
            isFloating = true
        }
    }
}

