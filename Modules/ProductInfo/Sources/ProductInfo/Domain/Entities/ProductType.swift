import Foundation

public enum ProductType: Equatable, Sendable {
    case accessories
    case giftCard
    case shoes
    case snowboard
    case tshirts
    case empty
    case unknown(String)

    public init(rawValue: String) {
        let trimmed = rawValue.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            self = .empty
            return
        }

        switch trimmed.lowercased() {
        case "accessories":
            self = .accessories
        case "giftcard":
            self = .giftCard
        case "shoes":
            self = .shoes
        case "snowboard":
            self = .snowboard
        case "t-shirts", "tshirts", "t shirts":
            self = .tshirts
        default:
            self = .unknown(trimmed)
        }
    }

    public var isComparable: Bool {
        switch self {
        case .accessories, .shoes, .snowboard, .tshirts:
            return true
        case .giftCard, .empty, .unknown:
            return false
        }
    }

    public var queryValue: String? {
        switch self {
        case .accessories:
            return "product_type:'accessories'"
        case .shoes:
            return "product_type:'SHOES'"
        case .snowboard:
            return "product_type:'snowboard'"
        case .tshirts:
            return "product_type:'T-SHIRTS'"
        case .giftCard, .empty, .unknown:
            return nil
        }
    }
}

public extension ProductDetails {
    var normalizedProductType: ProductType {
        ProductType(rawValue: productType)
    }
}
