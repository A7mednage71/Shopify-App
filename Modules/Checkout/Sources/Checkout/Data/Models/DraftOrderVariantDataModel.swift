import Foundation

public struct DraftOrderVariantDataModel: Equatable, Sendable {
    public let id: String
    public let title: String
    public let price: String
    public let inventoryQuantity: Int
    public let availableForSale: Bool

    public init(
        id: String,
        title: String,
        price: String,
        inventoryQuantity: Int,
        availableForSale: Bool
    ) {
        self.id = id
        self.title = title
        self.price = price
        self.inventoryQuantity = inventoryQuantity
        self.availableForSale = availableForSale
    }
}
