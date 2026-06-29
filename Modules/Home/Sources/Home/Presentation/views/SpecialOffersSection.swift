import SwiftUI
import Common

// MARK: - Special Offers Section
// Shopify API: Collection tagged "special-offers" OR metafield badge on products
// Products with compare_at_price set automatically qualify as "on sale"

struct SpecialOffersSection: View {
    var onTap: (() -> Void)? = nil
    
    var body: some View {
        Button(action: { onTap?() }) {
            
            HStack(spacing: 14) {
                
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color.appPrimaryOrange, Color.appPrimaryPink],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 54, height: 54)
                        .shadow(color: Color.appPrimaryOrange.opacity(0.3), radius: 6, x: 0, y: 3)
                    
                    Text("🎁")
                        .font(.system(size: 24))
                }
                
                // Text Content
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 6) {
                        Text(HomeStrings.SpecialOffers.title)
                            .font(.offerTitle)
                            .foregroundColor(.appTextPrimary)
                        
                        Text("😍")
                            .font(.system(size: 15))
                    }
                    
                    Text(HomeStrings.SpecialOffers.subtitle)
                        .font(.offerSubtitle)
                        .foregroundColor(.appTextSecondary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                // Chevron
                Image(systemName: "chevron.right")
                    .font(.sectionAction)
                    .foregroundColor(.appPrimaryOrange)
                    .frame(width: 28, height: 28)
                    .background(Color.appBackgroundWhite)
                    .clipShape(Circle())
                    .shadow(color: Color.appPrimaryOrange.opacity(0.15), radius: 4, x: 0, y: 2)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                LinearGradient(
                    colors: [Color.appPrimaryOrange.opacity(0.08), Color.appPrimaryOrange.opacity(0.03)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(
                        LinearGradient(
                            colors: [Color.appPrimaryOrange.opacity(0.18), Color.appPrimaryOrange.opacity(0.08)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            .padding(.horizontal, 16)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview
#Preview {
    SpecialOffersSection()
        .padding(.vertical)
}
