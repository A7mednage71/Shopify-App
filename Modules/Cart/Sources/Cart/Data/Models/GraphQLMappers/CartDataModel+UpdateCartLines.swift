@preconcurrency import MarktekNetworking

extension CartDataModel {
    init(cart: UpdateCartLinesMutation.Data.CartLinesUpdate.Cart) {
        self.id = cart.id
        self.checkoutUrl = nil
        self.totalQuantity = cart.totalQuantity
        self.discountCodes = []
        self.cost = CartCostDataModel(
            subtotalAmount: CartMoneyDataModel(money: cart.cost.subtotalAmount),
            totalAmount: CartMoneyDataModel(money: cart.cost.totalAmount),
            totalTaxAmount: nil,
            checkoutChargeAmount: nil
        )
        self.lines = cart.lines.edges.map { CartLineDataModel(node: $0.node) }
    }
}

extension CartLineDataModel {
    init(node: UpdateCartLinesMutation.Data.CartLinesUpdate.Cart.Lines.Edge.Node) {
        self.id = node.id
        self.quantity = node.quantity
        self.cost = nil
        self.variant = node.merchandise.asProductVariant.map { CartProductVariantDataModel(variant: $0) }
    }
}

extension CartProductVariantDataModel {
    init(variant: UpdateCartLinesMutation.Data.CartLinesUpdate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant) {
        self.id = variant.id
        self.title = variant.title
        self.price = nil
        self.compareAtPrice = nil
        self.availableForSale = variant.availableForSale
        self.quantityAvailable = variant.quantityAvailable
        self.selectedOptions = []
        self.image = nil
        self.product = nil
    }
}
