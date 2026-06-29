@preconcurrency import MarktekNetworking

extension CartDataModel {
    init(cart: ApplyDiscountCodeMutation.Data.CartDiscountCodesUpdate.Cart) {
        self.id = cart.id
        self.checkoutUrl = nil
        self.totalQuantity = nil
        self.discountCodes = cart.discountCodes.map { CartDiscountCodeDataModel(discountCode: $0) }
        self.cost = CartCostDataModel(
            subtotalAmount: CartMoneyDataModel(money: cart.cost.subtotalAmount),
            totalAmount: CartMoneyDataModel(money: cart.cost.totalAmount),
            totalTaxAmount: nil,
            checkoutChargeAmount: nil
        )
        self.lines = []
    }
}

extension CartDiscountCodeDataModel {
    init(discountCode: ApplyDiscountCodeMutation.Data.CartDiscountCodesUpdate.Cart.DiscountCode) {
        self.code = discountCode.code
        self.applicable = discountCode.applicable
    }
}
