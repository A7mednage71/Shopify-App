@preconcurrency import MarktekNetworking

extension CartDataModel {
    init(cart: CreateCartMutation.Data.CartCreate.Cart) {
        self.id = cart.id
        self.checkoutUrl = cart.checkoutUrl
        self.totalQuantity = cart.totalQuantity
        self.discountCodes = []
        self.cost = CartCostDataModel(
            subtotalAmount: CartMoneyDataModel(money: cart.cost.subtotalAmount),
            totalAmount: CartMoneyDataModel(money: cart.cost.totalAmount),
            totalTaxAmount: cart.cost.totalTaxAmount.map { CartMoneyDataModel(money: $0) },
            checkoutChargeAmount: nil
        )
        self.lines = cart.lines.edges.map { CartLineDataModel(node: $0.node) }
    }
}

extension CartLineDataModel {
    init(node: CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node) {
        self.id = node.id
        self.quantity = node.quantity
        self.cost = CartLineCostDataModel(cost: node.cost)
        self.variant = node.merchandise.asProductVariant.map { CartProductVariantDataModel(variant: $0) }
    }
}

extension CartLineCostDataModel {
    init(cost: CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node.Cost) {
        self.totalAmount = CartMoneyDataModel(money: cost.totalAmount)
        self.amountPerQuantity = nil
        self.compareAtAmountPerQuantity = nil
    }
}

extension CartProductVariantDataModel {
    init(variant: CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant) {
        self.id = variant.id
        self.title = variant.title
        self.price = CartMoneyDataModel(money: variant.price)
        self.compareAtPrice = nil
        self.availableForSale = variant.availableForSale
        self.quantityAvailable = variant.quantityAvailable
        self.selectedOptions = []
        self.image = variant.image.map { CartVariantImageDataModel(image: $0) }
        self.product = CartProductSummaryDataModel(product: variant.product)
    }
}

extension CartVariantImageDataModel {
    init(image: CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Image) {
        self.url = image.url
        self.altText = image.altText
    }
}

extension CartProductSummaryDataModel {
    init(product: CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Product) {
        self.id = product.id
        self.title = product.title
        self.vendor = product.vendor
    }
}
