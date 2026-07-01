import SwiftUI
import Common

struct ProductCardsSection: View {
    let products: [Product]
    var onProductTap: ((Product) -> Void)? = nil

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            // 👈 الـ spacing: 12 هنا هو الذي يتحكم بالمسافة بين كل كارت والتالي
            HStack(alignment: .top, spacing: 12) {
                ForEach(products) { product in
                    ProductCard(product: product)
                        // 👈 حافظنا على الـ padding العمودي فقط عشان الـ Shadow يظهر بوضوح ولا يُقص
                        .padding(.vertical, 8)
                        // 👈 تم حذف .padding(.horizontal, 8) من هنا لأنه كان يسبب التباعد الزائد
                        .onTapGesture { onProductTap?(product) }
                }
            }
            .padding(.horizontal, 16) // المسافة من أطراف الشاشة اليمين واليسار فقط
        }
    }
}

#Preview {
    ScrollView { ProductCardsSection(products: MockShopifyData.featuredProducts) }
    .background(Color.appBackgroundGray)
}
