@preconcurrency import MarktekNetworking

extension CartDataModel {
    init(cart: GetCartQuery.Data.Cart) {
        self.id = cart.id
        self.checkoutUrl = cart.checkoutUrl
        self.totalQuantity = cart.totalQuantity
        self.discountCodes = cart.discountCodes.map { CartDiscountCodeDataModel(discountCode: $0) }
        self.cost = CartCostDataModel(
            subtotalAmount: CartMoneyDataModel(money: cart.cost.subtotalAmount),
            totalAmount: CartMoneyDataModel(money: cart.cost.totalAmount),
            totalTaxAmount: cart.cost.totalTaxAmount.map { CartMoneyDataModel(money: $0) },
            checkoutChargeAmount: CartMoneyDataModel(money: cart.cost.checkoutChargeAmount)
        )
        self.lines = cart.lines.edges.map { CartLineDataModel(node: $0.node) }
    }
}

extension CartDiscountCodeDataModel {
    init(discountCode: GetCartQuery.Data.Cart.DiscountCode) {
        self.code = discountCode.code
        self.applicable = discountCode.applicable
    }
}

extension CartLineDataModel {
    init(node: GetCartQuery.Data.Cart.Lines.Edge.Node) {
        self.id = node.id
        self.quantity = node.quantity
        self.cost = CartLineCostDataModel(cost: node.cost)
        self.variant = node.merchandise.asProductVariant.map { CartProductVariantDataModel(variant: $0) }
    }
}

extension CartLineCostDataModel {
    init(cost: GetCartQuery.Data.Cart.Lines.Edge.Node.Cost) {
        self.totalAmount = CartMoneyDataModel(money: cost.totalAmount)
        self.amountPerQuantity = CartMoneyDataModel(money: cost.amountPerQuantity)
        self.compareAtAmountPerQuantity = cost.compareAtAmountPerQuantity.map { CartMoneyDataModel(money: $0) }
    }
}

extension CartProductVariantDataModel {
    init(variant: GetCartQuery.Data.Cart.Lines.Edge.Node.Merchandise.AsProductVariant) {
        self.id = variant.id
        self.title = variant.title
        self.price = CartMoneyDataModel(money: variant.price)
        self.compareAtPrice = variant.compareAtPrice.map { CartMoneyDataModel(money: $0) }
        self.availableForSale = variant.availableForSale
        self.quantityAvailable = variant.quantityAvailable
        self.selectedOptions = variant.selectedOptions.map { CartSelectedOptionDataModel(selectedOption: $0) }
        self.image = variant.image.map { CartVariantImageDataModel(image: $0) }
        self.product = CartProductSummaryDataModel(product: variant.product)
    }
}

extension CartSelectedOptionDataModel {
    init(selectedOption: GetCartQuery.Data.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.SelectedOption) {
        self.name = selectedOption.name
        self.value = selectedOption.value
    }
}

extension CartVariantImageDataModel {
    init(image: GetCartQuery.Data.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Image) {
        self.url = image.url
        self.altText = image.altText
    }
}

extension CartProductSummaryDataModel {
    init(product: GetCartQuery.Data.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Product) {
        self.id = product.id
        self.title = product.title
        self.vendor = product.vendor
    }
}
