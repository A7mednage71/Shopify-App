public struct CartProductVariant: Identifiable, Equatable, Sendable {
    public let id: String
    public let title: String
    public let price: CartMoney?
    public let compareAtPrice: CartMoney?
    public let availableForSale: Bool?
    public let quantityAvailable: Int?
    public let selectedOptions: [CartSelectedOption]
    public let image: CartVariantImage?
    public let product: CartProductSummary?

    public init(
        id: String,
        title: String,
        price: CartMoney?,
        compareAtPrice: CartMoney?,
        availableForSale: Bool?,
        quantityAvailable: Int?,
        selectedOptions: [CartSelectedOption],
        image: CartVariantImage?,
        product: CartProductSummary?
    ) {
        self.id = id
        self.title = title
        self.price = price
        self.compareAtPrice = compareAtPrice
        self.availableForSale = availableForSale
        self.quantityAvailable = quantityAvailable
        self.selectedOptions = selectedOptions
        self.image = image
        self.product = product
    }
}

public struct CartSelectedOption: Equatable, Sendable {
    public let name: String
    public let value: String

    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}

public struct CartVariantImage: Equatable, Sendable {
    public let url: String
    public let altText: String?

    public init(url: String, altText: String?) {
        self.url = url
        self.altText = altText
    }
}

public struct CartProductSummary: Equatable, Sendable {
    public let id: String?
    public let title: String
    public let vendor: String

    public init(id: String?, title: String, vendor: String) {
        self.id = id
        self.title = title
        self.vendor = vendor
    }
}
