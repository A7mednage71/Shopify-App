import Foundation

// MARK: - Search Response Models
struct SearchResponseData: Codable {
    let data: SearchData
}

struct SearchData: Codable {
    let search: ShopProductConnection
}

struct ShopProductConnection: Codable {
    let totalCount: Int
    let edges: [ShopProductEdge]
    let pageInfo: PageInfo
}

struct ShopProductEdge: Codable {
    let cursor: String
    let node: ShopProductNode
}

struct PageInfo: Codable {
    let hasNextPage: Bool
    let endCursor: String?
}

// MARK: - Shop Product Node
struct ShopProductNode: Codable {
    let id: String
    let title: String
    let description: String
    let handle: String
    let vendor: String?
    let productType: String?
    let tags: [String]
    let availableForSale: Bool
    let options: [ProductOptionDataModel]
    let priceRange: PriceRange
    let images: ImageConnection
    let variants: VariantConnection
}

struct ProductOptionDataModel: Codable, Sendable {
    let name: String
    let values: [String]
}

struct PriceRange: Codable {
    let minVariantPrice: Money
    let maxVariantPrice: Money
}

struct Money: Codable {
    let amount: String
    let currencyCode: String
}

struct ImageConnection: Codable {
    let edges: [ImageEdge]
}

struct ImageEdge: Codable {
    let node: ImageNode
}

struct ImageNode: Codable {
    let url: String
    let altText: String?
}

struct VariantConnection: Codable {
    let edges: [VariantEdge]
}

struct VariantEdge: Codable {
    let node: ProductVariantDataModel
}

struct ProductVariantDataModel: Codable, Sendable {
    let id: String
    let title: String
    let availableForSale: Bool
    let price: Money
}
