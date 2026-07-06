import Foundation

// MARK: - AI Catalog Product
public struct AICatalogProduct: Codable, Identifiable, Sendable {
    public var id: String { productId }
    public let productId: String
    public let name: String
    public let vendor: String
    public let colors: [String]
    public let sizes: [String]
    public let price: Double

    public init(productId: String, name: String, vendor: String, colors: [String], sizes: [String], price: Double) {
        self.productId = productId
        self.name = name
        self.vendor = vendor
        self.colors = colors
        self.sizes = sizes
        self.price = price
    }
}

// MARK: - AI Catalog Collection
public struct AICatalogCollection: Codable, Sendable {
    public let id: String
    public let title: String
    public let handle: String
    public let imageURL: String?
}

public extension Collection {
    func toAICatalogCollection() -> AICatalogCollection {
        AICatalogCollection(id: id, title: title, handle: handle, imageURL: imageURL)
    }
}

// MARK: - Chat Message
public struct ChatMessage: Identifiable, Sendable {
    public enum Role: Sendable { case user, assistant }
    public let id: UUID
    public let role: Role
    public let text: String
    public var productIds: [String]
    public var brandIds: [String]
    public var categoryIds: [String]

    public init(id: UUID = UUID(), role: Role, text: String, productIds: [String] = [], brandIds: [String] = [], categoryIds: [String] = []) {
        self.id = id
        self.role = role
        self.text = text
        self.productIds = productIds
        self.brandIds = brandIds
        self.categoryIds = categoryIds
    }
}

// MARK: - API Payloads
public struct GeminiRequestMessage: Codable {
    public let role: String
    public let text: String
    
    public init(role: String, text: String) {
        self.role = role
        self.text = text
    }
}

public struct GeminiProxyRequest: Codable {
    public let history: [GeminiRequestMessage]
    public let products: [AICatalogProduct]
    
    public init(history: [GeminiRequestMessage], products: [AICatalogProduct]) {
        self.history = history
        self.products = products
    }
}

public struct AssistantReply: Codable, Sendable {
    public let reply: String
    public let product_ids: [String]
    public let brand_ids: [String]
    public let category_ids: [String]
    
    enum CodingKeys: String, CodingKey {
        case reply
        case product_ids = "product_ids"
        case brand_ids = "brand_ids"
        case category_ids = "category_ids"
    }
    
    public init(reply: String, product_ids: [String], brand_ids: [String] = [], category_ids: [String] = []) {
        self.reply = reply
        self.product_ids = product_ids
        self.brand_ids = brand_ids
        self.category_ids = category_ids
    }
}

// MARK: - Mapper Extension
public extension ShopProduct {
    func toAICatalogProduct() -> AICatalogProduct {

        // Extract sizes
        let sizeOption = options.first { option in
            let lowerName = option.name.lowercased()
            return lowerName.contains("size") || lowerName.contains("مقاس")
        }
        let sizes = sizeOption?.values ?? []

        // Extract colors
        let colorOption = options.first { option in
            let lowerName = option.name.lowercased()
            return lowerName.contains("color") || lowerName.contains("اللون") || lowerName.contains("لون")
        }
        let colors = colorOption?.values ?? []

        let parsedPrice = Double(price) ?? 0.0

        return AICatalogProduct(
            productId: id,
            name: title,
            vendor: vendor ?? "",
            colors: colors,
            sizes: sizes,
            price: parsedPrice
        )
    }
}
