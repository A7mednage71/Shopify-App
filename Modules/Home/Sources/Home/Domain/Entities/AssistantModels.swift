import Foundation

// MARK: - AI Catalog Product
public struct AICatalogProduct: Codable, Identifiable, Sendable {
    public var id: String { productId }
    public let productId: String
    public let name: String
    public let vendor: String
    public let category: String   // "men" | "women" | "kid"
    public let colors: [String]
    public let sizes: [String]
    public let price: Double

    public init(productId: String, name: String, vendor: String, category: String, colors: [String], sizes: [String], price: Double) {
        self.productId = productId
        self.name = name
        self.vendor = vendor
        self.category = category
        self.colors = colors
        self.sizes = sizes
        self.price = price
    }

    public var categoryLabel: String {
        switch category {
        case "men": return "Men"
        case "women": return "Women"
        case "kid": return "Kids"
        default: return category.capitalized
        }
    }
}

// MARK: - Chat Message
public struct ChatMessage: Identifiable, Sendable {
    public enum Role: Sendable { case user, assistant }
    public let id: UUID
    public let role: Role
    public let text: String
    public var productIds: [String]

    public init(id: UUID = UUID(), role: Role, text: String, productIds: [String] = []) {
        self.id = id
        self.role = role
        self.text = text
        self.productIds = productIds
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
    
    public init(reply: String, product_ids: [String]) {
        self.reply = reply
        self.product_ids = product_ids
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

        // Extract category (men, women, kid)
        var category = "men" // default
        let lowerTitle = title.lowercased()
        let lowerType = (productType ?? "").lowercased()
        let tagsCombined = tags.map { $0.lowercased() }

        if lowerTitle.contains("women") || lowerTitle.contains("حريمي") || lowerType.contains("women") || tagsCombined.contains("women") || tagsCombined.contains("حريمي") {
            category = "women"
        } else if lowerTitle.contains("kid") || lowerTitle.contains("أطفال") || lowerTitle.contains("child") || lowerType.contains("kid") || tagsCombined.contains("kid") || tagsCombined.contains("أطفال") {
            category = "kid"
        }

        let parsedPrice = Double(price) ?? 0.0

        return AICatalogProduct(
            productId: id,
            name: title,
            vendor: vendor ?? "",
            category: category,
            colors: colors,
            sizes: sizes,
            price: parsedPrice
        )
    }
}
