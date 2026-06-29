import Foundation
import SwiftUI

// MARK: - Shopify API Models
// These map directly to Shopify Storefront API GraphQL responses

// MARK: - Product Model (from Shopify products query)
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
}

// MARK: - Collection / Category (from Shopify collections query)
struct ShopifyCollection: Identifiable {
    let id: String
    let title: String
    let handle: String
    let imageURL: String?
}

// MARK: - Deal of the Day Model
// Requires Shopify metafield: custom.deal_end_time (date_time type)
struct DealOfDay {
    let product: ShopifyProduct
    let endDate: Date               // from metafield
    
    var timeRemaining: (hours: Int, minutes: Int, seconds: Int) {
        let remaining = max(0, endDate.timeIntervalSince(Date()))
        let h = Int(remaining) / 3600
        let m = (Int(remaining) % 3600) / 60
        let s = Int(remaining) % 60
        return (h, m, s)
    }
}

// MARK: - Hero Banner Model
// Requires Shopify metafield or Theme customizer
struct HeroBanner: Identifiable {
    let id: String
    let title: String               // "50-40% OFF"
    let subtitle: String            // "Now in (product)"
    let ctaText: String             // "Shop Now"
    let ctaHandle: String           // collection or product handle
    let imageURL: String
    let gradientColors: [Color]     // per-banner gradient
}

// MARK: - Mock Data (replace with real Shopify API calls)
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
            ctaText: "Shop Now",
            ctaHandle: "sale",
            imageURL: "https://picsum.photos/seed/banner1/400/200",
            gradientColors: [Color(red: 1.0, green: 0.45, blue: 0.0), Color(red: 1.0, green: 0.65, blue: 0.1)]
        ),
        HeroBanner(
            id: "2",
            title: "New Arrivals",
            subtitle: "Fresh styles just landed",
            ctaText: "Explore",
            ctaHandle: "new-arrivals",
            imageURL: "https://picsum.photos/seed/banner2/400/200",
            gradientColors: [Color(red: 0.05, green: 0.35, blue: 0.50), Color(red: 0.1, green: 0.55, blue: 0.65)]
        ),
        HeroBanner(
            id: "3",
            title: "Top Brands",
            subtitle: "Exclusive deals on premium brands",
            ctaText: "Discover",
            ctaHandle: "brands",
            imageURL: "https://picsum.photos/seed/banner3/400/200",
            gradientColors: [Color(red: 0.30, green: 0.15, blue: 0.65), Color(red: 0.55, green: 0.25, blue: 0.85)]
        )
    ]
    
    static let featuredProducts: [ShopifyProduct] = [
        ShopifyProduct(
            id: "1",
            title: "Women Printed Kurta",
            description: "Neque porro quisquam est qui dolorem ipsum quia",
            handle: "women-printed-kurta",
            featuredImageURL: "https://picsum.photos/seed/kurta/300/300",
            price: 1500,
            compareAtPrice: 2499,
            currencyCode: "INR",
            rating: 4.0,
            reviewCount: 56890
        ),
        ShopifyProduct(
            id: "2",
            title: "HRX by Hrithik Roshan",
            description: "Neque porro quisquam est qui dolorem ipsum quia",
            handle: "hrx-sneakers",
            featuredImageURL: "https://picsum.photos/seed/shoes/300/300",
            price: 2499,
            compareAtPrice: 4999,
            currencyCode: "INR",
            rating: 4.5,
            reviewCount: 344567
        ),
        ShopifyProduct(
            id: "3",
            title: "Flat and Heels",
            description: "Stand a chance to get rewarded",
            handle: "heels",
            featuredImageURL: "https://picsum.photos/seed/heels/300/300",
            price: 899,
            compareAtPrice: 1499,
            currencyCode: "INR",
            rating: 4.2,
            reviewCount: 12300
        )
    ]
    
    static let dealOfDay = DealOfDay(
        product: featuredProducts[0],
        endDate: Date().addingTimeInterval(22 * 3600 + 55 * 60 + 20)
    )
    
    static let trendingProducts: [ShopifyProduct] = [
        ShopifyProduct(id: "4", title: "Watch Collection", description: "", handle: "watch", featuredImageURL: "https://picsum.photos/seed/watch/300/300", price: 3999, compareAtPrice: nil, currencyCode: "INR", rating: 4.8, reviewCount: 2300),
        ShopifyProduct(id: "5", title: "White Sneakers", description: "", handle: "sneakers", featuredImageURL: "https://picsum.photos/seed/sneak/300/300", price: 1299, compareAtPrice: 1999, currencyCode: "INR", rating: 4.3, reviewCount: 8900),
        ShopifyProduct(id: "6", title: "Summer Dress", description: "", handle: "dress", featuredImageURL: "https://picsum.photos/seed/dress/300/300", price: 2199, compareAtPrice: 3499, currencyCode: "INR", rating: 4.6, reviewCount: 5600),
    ]

    // All products merged — used for search (replace with real API)
    static let allProducts: [ShopifyProduct] = featuredProducts + trendingProducts + [
        ShopifyProduct(id: "7",  title: "Black Winter Jacket",        description: "Autumn And Winter Casual cotton-padded jacket",   handle: "jacket",   featuredImageURL: "https://picsum.photos/seed/jacket/300/300",   price: 499,  compareAtPrice: nil,  currencyCode: "INR", rating: 4.0, reviewCount: 6890),
        ShopifyProduct(id: "8",  title: "Mens Starry Shirt",          description: "Mens Starry Sky Printed Shirt 100% Cotton Fabric", handle: "shirt",    featuredImageURL: "https://picsum.photos/seed/shirt/300/300",    price: 399,  compareAtPrice: nil,  currencyCode: "INR", rating: 3.5, reviewCount: 152344),
        ShopifyProduct(id: "9",  title: "Black Dress",                description: "Solid Black Dress for Women, Sexy Chain Shorts",   handle: "bdress",   featuredImageURL: "https://picsum.photos/seed/bdress/300/300",   price: 2000, compareAtPrice: nil,  currencyCode: "INR", rating: 4.2, reviewCount: 523456),
        ShopifyProduct(id: "10", title: "Pink Embroidered Dress",     description: "EARTHEN Rose Pink Embroidered Tiered Maxi",        handle: "pdress",   featuredImageURL: "https://picsum.photos/seed/pdress/300/300",   price: 1900, compareAtPrice: nil,  currencyCode: "INR", rating: 4.4, reviewCount: 45678),
        ShopifyProduct(id: "11", title: "Blue Denim Jacket",          description: "Classic denim jacket with faded wash finish",      handle: "denim",    featuredImageURL: "https://picsum.photos/seed/denim/300/300",    price: 1599, compareAtPrice: 2400, currencyCode: "INR", rating: 4.1, reviewCount: 3200),
        ShopifyProduct(id: "12", title: "Gold Hoop Earrings",         description: "18K gold plated lightweight hoop earrings",        handle: "earrings", featuredImageURL: "https://picsum.photos/seed/earrings/300/300", price: 299,  compareAtPrice: nil,  currencyCode: "INR", rating: 4.7, reviewCount: 9800),
    ]
}
