import SwiftUI
import Common

struct MessageRow: View {
    let message: ChatMessage
    let products: [ShopProduct]
    let brandCollections: [Collection]
    let categoryCollections: [Collection]
    let onProductTap: (String) -> Void

    init(
        message: ChatMessage,
        products: [ShopProduct],
        brandCollections: [Collection],
        categoryCollections: [Collection],
        onProductTap: @escaping (String) -> Void
    ) {
        self.message = message
        self.products = products
        self.brandCollections = brandCollections
        self.categoryCollections = categoryCollections
        self.onProductTap = onProductTap
    }

    public var body: some View {
        HStack(alignment: .top, spacing: 10) {
            if message.role == .assistant {
                // AI Sparkle Avatar
                Image(systemName: "sparkles")
                    .font(.assistantButtonSmall)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(AppColors.primary)
                    .clipShape(Circle())
                    .shadow(color: AppColors.primary.opacity(0.2), radius: 4, x: 0, y: 2)
            } else {
                Spacer(minLength: 50)
            }

            VStack(alignment: message.role == .user ? .trailing : .leading, spacing: 8) {
                Text(message.text)
                    .font(.assistantBubble)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(message.role == .user ? AppColors.primary : AppColors.background)
                    .foregroundColor(message.role == .user ? AppColors.textWhite : AppColors.textPrimary)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: Color.black.opacity(0.04), radius: 3, x: 0, y: 1.5)
                    .frame(maxWidth: 280, alignment: message.role == .user ? .trailing : .leading)

                if !products.isEmpty {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(products) { product in
                            ProductCardView(product: product, onTap: onProductTap)
                        }
                    }
                    .padding(.top, 4)
                    .frame(maxWidth: 290)
                }
                
                if !brandCollections.isEmpty {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Brands")
                            .font(.assistantSectionTitle)
                            .foregroundColor(AppColors.textPrimary)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(brandCollections) { brand in
                                    NavigationLink(destination: VendorProductsView(vendorName: brand.title, viewModel: HomeAssembler.resolveHomeViewModel(), onProductTap: onProductTap)) {
                                        BrandItem(brand: brand)
                                            .frame(width: 80)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .padding(.top, 4)
                    .frame(maxWidth: 290)
                }

                if !categoryCollections.isEmpty {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Categories")
                            .font(.assistantSectionTitle)
                            .foregroundColor(AppColors.textPrimary)
                            .padding(.leading, 4)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(categoryCollections) { category in
                                    NavigationLink(destination: CategoryProductsView(category: category, viewModel: HomeAssembler.resolveHomeViewModel(), onProductTap: onProductTap)) {
                                        CategoryItem(category: category)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .padding(.top, 4)
                    .frame(maxWidth: 290)
                }
            }

            if message.role == .user {
                // Spacer to push user message to the right
            } else {
                Spacer(minLength: 50)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.role == .user ? .trailing : .leading)
    }
}
