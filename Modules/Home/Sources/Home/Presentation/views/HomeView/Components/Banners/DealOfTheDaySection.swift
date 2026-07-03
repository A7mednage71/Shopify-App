import SwiftUI
import Common

// MARK: - Deal of the Day Section

struct DealOfTheDaySection: View {
    let deal: DealOfDay
    var onViewAll: (() -> Void)? = nil

    @State private var timeRemaining: (hours: Int, minutes: Int, seconds: Int) = (0, 0, 0)
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        
        VStack(spacing: 0) {

            HStack(alignment: .center) {
                HStack(spacing: 6) {
                    Image(systemName: "bolt.fill")
                        .font(.dealIcon)
                        .foregroundColor(.appTextWhite)

                    Text(HomeStrings.Deal.sectionTitle)
                        .font(.sectionTitle)
                        .foregroundColor(.appTextWhite)
                }

                Spacer()

                Button(action: { onViewAll?() }) {
                    HStack(spacing: 5) {
                        Text(HomeStrings.Deal.viewAll)
                            .font(.buttonSmall)
                            .foregroundColor(.appTextWhite)
                        Text("→")
                            .font(.sectionAction)
                            .foregroundColor(.appTextWhite)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.appTextWhite, lineWidth: 1.5)
                    )
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 16)
            .padding(.top, 14)
            .padding(.bottom, 10)

            Rectangle()
                .fill(Color.appWhiteOverlayMedium)
                .frame(height: 1)
                .padding(.horizontal, 16)

            HStack(spacing: 8) {
                Image(systemName: "timer")
                    .font(.dealIndicator)
                    .foregroundColor(.appTextWhiteSecondary)

                // Time blocks
                HStack(spacing: 6) {
                    TimeBlock(value: timeRemaining.hours, label: "h")
                    Text(":")
                        .font(.timerText)
                        .foregroundColor(.appTextWhiteTertiary)
                    TimeBlock(value: timeRemaining.minutes, label: "m")
                    Text(":")
                        .font(.timerText)
                        .foregroundColor(.appTextWhiteTertiary)
                    TimeBlock(value: timeRemaining.seconds, label: "s")
                }

                Text(HomeStrings.Deal.remaining)
                    .font(.dealIndicator)
                    .foregroundColor(.appTextWhiteSecondary)

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(
            LinearGradient(
                colors: [Color.appPrimaryOrange, Color.appPrimaryOrangeSecondary],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.appOrangeShadow, radius: 8, x: 0, y: 4)
        .padding(.horizontal, 16)
        .onAppear { timeRemaining = deal.timeRemaining }
        .onReceive(timer) { _ in timeRemaining = deal.timeRemaining }
    }
}

// MARK: - Time Block
private struct TimeBlock: View {
    let value: Int
    let label: String

    var body: some View {
        HStack(spacing: 2) {
            Text(String(format: "%02d", value))
                .font(.timerText)
                .foregroundColor(.appTextWhite)
                .monospacedDigit()

            Text(label)
                .font(.dealUnitLabel)
                .foregroundColor(.appTextWhiteSecondary)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.appWhiteOverlayLight)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.appBackgroundGray.ignoresSafeArea()
        DealOfTheDaySection(deal: MockShopifyData.dealOfDay)
            .padding(.vertical)
    }
}
