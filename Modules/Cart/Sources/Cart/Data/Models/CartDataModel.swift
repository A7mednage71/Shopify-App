struct CartDataModel: Sendable {
    let id: String
    let checkoutUrl: String?
    let totalQuantity: Int?
    let discountCodes: [CartDiscountCodeDataModel]
    let cost: CartCostDataModel
    let lines: [CartLineDataModel]
}

struct CartDiscountCodeDataModel: Sendable {
    let code: String
    let applicable: Bool
}

struct CartCostDataModel: Sendable {
    let subtotalAmount: CartMoneyDataModel
    let totalAmount: CartMoneyDataModel
    let totalTaxAmount: CartMoneyDataModel?
    let checkoutChargeAmount: CartMoneyDataModel?
}

struct CartMoneyDataModel: Sendable {
    let amount: String
    let currencyCode: String
}

struct CartLineDataModel: Sendable {
    let id: String
    let quantity: Int
    let cost: CartLineCostDataModel?
    let variant: CartProductVariantDataModel?
}

struct CartLineCostDataModel: Sendable {
    let totalAmount: CartMoneyDataModel?
    let amountPerQuantity: CartMoneyDataModel?
    let compareAtAmountPerQuantity: CartMoneyDataModel?
}

struct CartProductVariantDataModel: Sendable {
    let id: String
    let title: String
    let price: CartMoneyDataModel?
    let compareAtPrice: CartMoneyDataModel?
    let availableForSale: Bool?
    let quantityAvailable: Int?
    let selectedOptions: [CartSelectedOptionDataModel]
    let image: CartVariantImageDataModel?
    let product: CartProductSummaryDataModel?
}

struct CartSelectedOptionDataModel: Sendable {
    let name: String
    let value: String
}

struct CartVariantImageDataModel: Sendable {
    let url: String
    let altText: String?
}

struct CartProductSummaryDataModel: Sendable {
    let id: String?
    let title: String
    let vendor: String
}

struct CartUserErrorDataModel: Sendable {
    let code: String?
    let field: [String]
    let message: String
}
