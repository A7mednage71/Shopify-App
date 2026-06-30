@preconcurrency import MarktekNetworking

extension CartDataModel {
    init(cart: RemoveCartLinesMutation.Data.CartLinesRemove.Cart) {
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
    init(node: RemoveCartLinesMutation.Data.CartLinesRemove.Cart.Lines.Edge.Node) {
        self.id = node.id
        self.quantity = node.quantity
        self.cost = nil
        self.variant = node.merchandise.asProductVariant.map { CartProductVariantDataModel(variant: $0) }
    }
}

extension CartProductVariantDataModel {
    init(variant: RemoveCartLinesMutation.Data.CartLinesRemove.Cart.Lines.Edge.Node.Merchandise.AsProductVariant) {
        self.id = variant.id
        self.title = variant.title
        self.price = nil
        self.compareAtPrice = nil
        self.availableForSale = nil
        self.quantityAvailable = nil
        self.selectedOptions = []
        self.image = nil
        self.product = nil
    }
}
