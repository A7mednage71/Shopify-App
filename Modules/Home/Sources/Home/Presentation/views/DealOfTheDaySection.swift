import SwiftUI

// MARK: - Deal of the Day Section
// Shopify API: Product tagged "deal-of-the-day" OR metafield custom.deal_end_time
// GraphQL: products(first:1, query:"tag:deal-of-the-day") + metafield(namespace:"custom", key:"deal_end_time")

struct DealOfTheDaySection: View {
    let deal: DealOfDay
    var onViewAll: (() -> Void)? = nil
    
    @State private var timeRemaining: (hours: Int, minutes: Int, seconds: Int) = (0, 0, 0)
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Section Header — Orange bar
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "clock.fill")
                        .font(.system(size: 13))
                        .foregroundColor(.textWhite)
                    
                    Text("Deal of the Day")
                        .font(.sectionTitle)
                        .foregroundColor(.textWhite)
                }
                
                Spacer()
                
                Button(action: { onViewAll?() }) {
                    HStack(spacing: 4) {
                        Text("View all")
                            .font(.buttonSmall)
                            .foregroundColor(.textWhite)
                        Image(systemName: "arrow.right")
                            .font(.system(size: 11))
                            .foregroundColor(.textWhite)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.textWhite, lineWidth: 1)
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.primaryOrange)
            
            // Countdown Timer
            HStack(spacing: 6) {
                Image(systemName: "timer")
                    .font(.system(size: 12))
                    .foregroundColor(.primaryOrange)
                
                Text(String(format: "%02dh %02dm %02ds remaining",
                           timeRemaining.hours,
                           timeRemaining.minutes,
                           timeRemaining.seconds))
                    .font(.timerText)
                    .foregroundColor(.primaryOrange)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.primaryOrange.opacity(0.08))
        }
        .onAppear {
            timeRemaining = deal.timeRemaining
        }
        .onReceive(timer) { _ in
            timeRemaining = deal.timeRemaining
        }
    }
}

// MARK: - Preview
#Preview {
    DealOfTheDaySection(deal: MockShopifyData.dealOfDay)
}
