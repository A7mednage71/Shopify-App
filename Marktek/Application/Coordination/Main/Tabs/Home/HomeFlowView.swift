import SwiftUI

struct HomeFlowView: View {
    let productID: String
    let onProductDetailsTap: (String) -> Void

    var body: some View {
        VStack(spacing: 18) {
            Image(systemName: "house")
                .font(.system(size: 42, weight: .semibold))
                .foregroundColor(.secondary)

            Text("Home")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.primary)

            Button {
                onProductDetailsTap(productID)
            } label: {
                Label("View Product Details", systemImage: "bag")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}
