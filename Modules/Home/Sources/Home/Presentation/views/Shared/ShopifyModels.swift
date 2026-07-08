import Foundation
import SwiftUI

// MARK: - Shopify API Models
// These map directly to Shopify Storefront API GraphQL responses

// MARK: - SearchProduct Model (from Shopify products query)
struct ShopifyProduct: Identifiable {
    let id: String
    let title: String
    let description: String
    let handle: String
    let featuredImageURL: String
    let price: Double               // from priceRange.minVariantPrice.amount
    let compareAtPrice: Double?     // from compareAtPriceRange.minVariantPrice.amount
    let currencyCode: String        // "INR", "USD", etc.
    let rating: Double?             // from metafield: custom.rating (needs metafield setup)
    let reviewCount: Int?           // from metafield: custom.review_count
    
    // Computed
    var discountPercent: Int? {
        guard let compare = compareAtPrice, compare > price else { return nil }
        return Int(((compare - price) / compare) * 100)
    }
    
    var formattedPrice: String {
        let symbol = currencyCode == "INR" ? "₹" : "$"
        return "\(symbol)\(Int(price))"
    }
    
    var formattedComparePrice: String? {
        guard let compare = compareAtPrice else { return nil }
        let symbol = currencyCode == "INR" ? "₹" : "$"
        return "\(symbol)\(Int(compare))"
    }
    
    // Convert to common ShopProduct model
    func toProduct() -> ShopProduct {
        return ShopProduct(
            id: id,
            title: title,
            description: description,
            handle: handle,
            featuredImageURL: featuredImageURL.isEmpty ? nil : featuredImageURL,
            featuredImageAltText: nil,
            price: String(format: "%.2f", price),
            currencyCode: currencyCode,
            compareAtPrice: compareAtPrice.map { String(format: "%.2f", $0) },
            compareAtCurrencyCode: currencyCode,
            rating: rating,
            reviewCount: reviewCount
        )
    }
}

extension ShopifyProduct {
    init(product: ShopProduct) {
        self.id = product.id
        self.title = product.title
        self.description = product.description
        self.handle = product.handle
        self.featuredImageURL = product.featuredImageURL ?? ""
        self.price = Double(product.price) ?? 0.0
        self.compareAtPrice = product.compareAtPrice.flatMap { Double($0) }
        self.currencyCode = product.currencyCode
        self.rating = product.rating
        self.reviewCount = product.reviewCount
    }
}

// MARK: - Collection / Category (from Shopify collections query)
struct ShopifyCollection: Identifiable {
    let id: String
    let title: String
    let handle: String
    let imageURL: String?
}

// MARK: - Deal of the Day Model
struct DealOfDay {
    let product: ShopProduct
    let endDate: Date
    
    var timeRemaining: (hours: Int, minutes: Int, seconds: Int) {
        let remaining = max(0, endDate.timeIntervalSince(Date()))
        let h = Int(remaining) / 3600
        let m = (Int(remaining) % 3600) / 60
        let s = Int(remaining) % 60
        return (h, m, s)
    }
}

// MARK: - Hero Banner Model
struct HeroBanner: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let ctaText: String
    let ctaHandle: String
    let imageURL: String
    let trailingImageName: String?
    let gradientColors: [Color]
    var couponCode: String?
}

// MARK: - Mock Data
struct MockShopifyData {
    
    static let categories: [ShopifyCollection] = [
        ShopifyCollection(id: "1", title: "Beauty",  handle: "beauty",  imageURL: "https://picsum.photos/seed/beauty/80/80"),
        ShopifyCollection(id: "2", title: "Fashion", handle: "fashion", imageURL: "https://picsum.photos/seed/fashion/80/80"),
        ShopifyCollection(id: "3", title: "Kids",    handle: "kids",    imageURL: "https://picsum.photos/seed/kids/80/80"),
        ShopifyCollection(id: "4", title: "Mens",    handle: "mens",    imageURL: "https://picsum.photos/seed/mens/80/80"),
        ShopifyCollection(id: "5", title: "Womens",  handle: "womens",  imageURL: "https://picsum.photos/seed/womens/80/80"),
    ]
    
    static let heroBanners: [HeroBanner] = [
        HeroBanner(
            id: "1",
            title: "50-40% OFF",
            subtitle: "Now in all products\nAll colours",
            ctaText: "Copy Code",
            ctaHandle: "sale",
            imageURL: "https://picsum.photos/seed/banner1/400/200",
            trailingImageName: "offer_discount_trailing",
            gradientColors: [Color(red: 1.0, green: 0.45, blue: 0.0), Color(red: 1.0, green: 0.65, blue: 0.1)],
            couponCode: "FIRST50"
        ),
        HeroBanner(
            id: "2",
            title: "Special Gift",
            subtitle: "Get $30 off on your order",
            ctaText: "Copy Code",
            ctaHandle: "new-arrivals",
            imageURL: "https://picsum.photos/seed/banner2/400/200",
            trailingImageName: "offer_special_gift_trailing",
            gradientColors: [Color(red: 0.05, green: 0.35, blue: 0.50), Color(red: 0.1, green: 0.55, blue: 0.65)],
            couponCode: "GIFT30"
        ),
        HeroBanner(
            id: "3",
            title: "Free Shipping",
            subtitle: "On all orders above $100",
            ctaText: "Copy Code",
            ctaHandle: "brands",
            imageURL: "https://picsum.photos/seed/banner3/400/200",
            trailingImageName: "offer_free_shipping_trailing",
            gradientColors: [Color(red: 0.30, green: 0.15, blue: 0.65), Color(red: 0.55, green: 0.25, blue: 0.85)],
            couponCode: "FREESHIPPING2026"
        )
    ]
    
    // MARK: - Featured Products (using ShopProduct model)
    static let featuredProducts: [ShopProduct] = [
        ShopProduct(
            id: "1",
            title: "Women Printed Kurta",
            description: "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit",
            handle: "women-printed-kurta",
            featuredImageURL: "https://picsum.photos/seed/kurta/400/400",
            featuredImageAltText: "Women Printed Kurta in floral design",
            price: "1500.00",
            currencyCode: "INR",
            compareAtPrice: "2499.00",
            compareAtCurrencyCode: "INR",
            rating: 4.0,
            reviewCount: 56890
        ),
        ShopProduct(
            id: "2",
            title: "HRX by Hrithik Roshan",
            description: "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit",
            handle: "hrx-sneakers",
            featuredImageURL: "https://picsum.photos/seed/shoes/400/400",
            featuredImageAltText: "HRX Sports Sneakers in black",
            price: "2499.00",
            currencyCode: "INR",
            compareAtPrice: "4999.00",
            compareAtCurrencyCode: "INR",
            rating: 4.5,
            reviewCount: 344567
        ),
        ShopProduct(
            id: "3",
            title: "Flat and Heels",
            description: "Stand a chance to get rewarded with every purchase",
            handle: "heels",
            featuredImageURL: "https://picsum.photos/seed/heels/400/400",
            featuredImageAltText: "Stylish flat heels in beige",
            price: "899.00",
            currencyCode: "INR",
            compareAtPrice: "1499.00",
            compareAtCurrencyCode: "INR",
            rating: 4.2,
            reviewCount: 12300
        ),
        ShopProduct(
            id: "4",
            title: "Men's Casual Shirt",
            description: "Comfortable cotton casual shirt for everyday wear",
            handle: "mens-casual-shirt",
            featuredImageURL: "https://picsum.photos/seed/shirt/400/400",
            featuredImageAltText: "Blue Men's Casual Shirt",
            price: "1299.00",
            currencyCode: "EGP",
            compareAtPrice: "1999.00",
            compareAtCurrencyCode: "EGP",
            rating: 4.3,
            reviewCount: 8900
        ),
        ShopProduct(
            id: "5",
            title: "Wireless Bluetooth Headphones",
            description: "Premium sound quality with noise cancellation",
            handle: "wireless-headphones",
            featuredImageURL: "https://picsum.photos/seed/headphones/400/400",
            featuredImageAltText: "Black wireless bluetooth headphones",
            price: "3499.00",
            currencyCode: "EGP",
            compareAtPrice: "4599.00",
            compareAtCurrencyCode: "EGP",
            rating: 4.8,
            reviewCount: 2500
        ),
        ShopProduct(
            id: "6",
            title: "Leather Handbag",
            description: "Elegant genuine leather handbag for women",
            handle: "leather-handbag",
            featuredImageURL: "https://picsum.photos/seed/handbag/400/400",
            featuredImageAltText: "Brown leather handbag",
            price: "2500.00",
            currencyCode: "EGP",
            compareAtPrice: nil,
            compareAtCurrencyCode: nil,
            rating: 4.6,
            reviewCount: 12300
        ),
        ShopProduct(
            id: "7",
            title: "Running Shoes Pro",
            description: "Lightweight running shoes with cushioning technology",
            handle: "running-shoes-pro",
            featuredImageURL: nil,
            featuredImageAltText: nil,
            price: "1899.00",
            currencyCode: "EGP",
            compareAtPrice: "2400.00",
            compareAtCurrencyCode: "EGP",
            rating: nil,
            reviewCount: nil
        ),
        ShopProduct(
            id: "8",
            title: "Smart Watch Series X",
            description: "Advanced fitness tracking with heart rate monitor",
            handle: "smart-watch-x",
            featuredImageURL: "https://picsum.photos/seed/watch/400/400",
            featuredImageAltText: "Smart Watch with black strap",
            price: "7999.00",
            currencyCode: "EGP",
            compareAtPrice: "9999.00",
            compareAtCurrencyCode: "EGP",
            rating: 4.7,
            reviewCount: 45600
        ),
        ShopProduct(
            id: "9",
            title: "Cotton T-Shirt Basic",
            description: "Essential cotton t-shirt for daily use",
            handle: "cotton-tshirt-basic",
            featuredImageURL: "https://picsum.photos/seed/tshirt/400/400",
            featuredImageAltText: "White basic cotton t-shirt",
            price: "499.00",
            currencyCode: "EGP",
            compareAtPrice: nil,
            compareAtCurrencyCode: nil,
            rating: 4.1,
            reviewCount: 34500
        ),
        ShopProduct(
            id: "10",
            title: "Professional Camera Lens",
            description: "High-quality lens for professional photography",
            handle: "pro-camera-lens",
            featuredImageURL: "https://picsum.photos/seed/camera/400/400",
            featuredImageAltText: "Professional camera lens",
            price: "15999.00",
            currencyCode: "EGP",
            compareAtPrice: "19999.00",
            compareAtCurrencyCode: "EGP",
            rating: 4.9,
            reviewCount: 890
        )
    ]
    
    static let dealOfDay = DealOfDay(
        product: featuredProducts[0],
        endDate: Date().addingTimeInterval(22 * 3600 + 55 * 60 + 20)
    )
    
    // MARK: - Trending Products (using SearchProduct model)
    static let trendingProducts: [ShopProduct] = [
        ShopProduct(
            id: "11",
            title: "Watch Collection",
            description: "Premium watch collection with leather straps",
            handle: "watch",
            featuredImageURL: "https://picsum.photos/seed/watch/300/300",
            featuredImageAltText: "Watch collection",
            price: "3999.00",
            currencyCode: "INR",
            compareAtPrice: nil,
            compareAtCurrencyCode: nil,
            rating: 4.8,
            reviewCount: 2300
        ),
        ShopProduct(
            id: "12",
            title: "White Sneakers",
            description: "Classic white sneakers for everyday wear",
            handle: "sneakers",
            featuredImageURL: "https://picsum.photos/seed/sneak/300/300",
            featuredImageAltText: "White sneakers",
            price: "1299.00",
            currencyCode: "INR",
            compareAtPrice: "1999.00",
            compareAtCurrencyCode: "INR",
            rating: 4.3,
            reviewCount: 8900
        ),
        ShopProduct(
            id: "13",
            title: "Summer Dress",
            description: "Light and flowy summer dress with floral pattern",
            handle: "dress",
            featuredImageURL: "https://picsum.photos/seed/dress/300/300",
            featuredImageAltText: "Summer dress",
            price: "2199.00",
            currencyCode: "INR",
            compareAtPrice: "3499.00",
            compareAtCurrencyCode: "INR",
            rating: 4.6,
            reviewCount: 5600
        ),
        ShopProduct(
            id: "14",
            title: "Black Winter Jacket",
            description: "Autumn And Winter Casual cotton-padded jacket",
            handle: "jacket",
            featuredImageURL: "https://picsum.photos/seed/jacket/300/300",
            featuredImageAltText: "Black winter jacket",
            price: "499.00",
            currencyCode: "INR",
            compareAtPrice: nil,
            compareAtCurrencyCode: nil,
            rating: 4.0,
            reviewCount: 6890
        ),
        ShopProduct(
            id: "15",
            title: "Mens Starry Shirt",
            description: "Mens Starry Sky Printed Shirt 100% Cotton Fabric",
            handle: "shirt",
            featuredImageURL: "https://picsum.photos/seed/shirt/300/300",
            featuredImageAltText: "Starry printed shirt",
            price: "399.00",
            currencyCode: "INR",
            compareAtPrice: nil,
            compareAtCurrencyCode: nil,
            rating: 3.5,
            reviewCount: 152344
        ),
        ShopProduct(
            id: "16",
            title: "Black Dress",
            description: "Solid Black Dress for Women, Sexy Chain Shorts",
            handle: "bdress",
            featuredImageURL: "https://picsum.photos/seed/bdress/300/300",
            featuredImageAltText: "Black dress for women",
            price: "2000.00",
            currencyCode: "INR",
            compareAtPrice: nil,
            compareAtCurrencyCode: nil,
            rating: 4.2,
            reviewCount: 523456
        ),
        ShopProduct(
            id: "17",
            title: "Pink Embroidered Dress",
            description: "EARTHEN Rose Pink Embroidered Tiered Maxi",
            handle: "pdress",
            featuredImageURL: "https://picsum.photos/seed/pdress/300/300",
            featuredImageAltText: "Pink embroidered maxi dress",
            price: "1900.00",
            currencyCode: "INR",
            compareAtPrice: nil,
            compareAtCurrencyCode: nil,
            rating: 4.4,
            reviewCount: 45678
        ),
        ShopProduct(
            id: "18",
            title: "Blue Denim Jacket",
            description: "Classic denim jacket with faded wash finish",
            handle: "denim",
            featuredImageURL: "https://picsum.photos/seed/denim/300/300",
            featuredImageAltText: "Blue denim jacket",
            price: "1599.00",
            currencyCode: "INR",
            compareAtPrice: "2400.00",
            compareAtCurrencyCode: "INR",
            rating: 4.1,
            reviewCount: 3200
        ),
        ShopProduct(
            id: "19",
            title: "Gold Hoop Earrings",
            description: "18K gold plated lightweight hoop earrings",
            handle: "earrings",
            featuredImageURL: "https://picsum.photos/seed/earrings/300/300",
            featuredImageAltText: "Gold hoop earrings",
            price: "299.00",
            currencyCode: "INR",
            compareAtPrice: nil,
            compareAtCurrencyCode: nil,
            rating: 4.7,
            reviewCount: 9800
        )
    ]

    // All products merged — used for search
    static let allProducts: [ShopProduct] = featuredProducts + trendingProducts
    
    // For preview/testing with single product
    static let sampleProduct = featuredProducts[0]
}
