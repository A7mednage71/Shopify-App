import SwiftUI

struct VendorProductsSkeletonView: View {
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(0..<4, id: \.self) { _ in
                Rectangle()
                    .fill(Color.appBackgroundWhite)
                    .frame(height: 290)
                    .cornerRadius(14)
                    .redacted(reason: .placeholder)
            }
        }
        .padding(.horizontal, 16)
    }
}
