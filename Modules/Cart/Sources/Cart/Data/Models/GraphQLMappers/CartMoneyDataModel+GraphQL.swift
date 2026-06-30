@preconcurrency import MarktekNetworking

extension CartMoneyDataModel {
    init(money: CreateCartMutation.Data.CartCreate.Cart.Cost.SubtotalAmount) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: CreateCartMutation.Data.CartCreate.Cart.Cost.TotalAmount) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: CreateCartMutation.Data.CartCreate.Cart.Cost.TotalTaxAmount) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node.Cost.TotalAmount) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Price) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: GetCartQuery.Data.Cart.Cost.SubtotalAmount) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: GetCartQuery.Data.Cart.Cost.TotalAmount) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: GetCartQuery.Data.Cart.Cost.TotalTaxAmount) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: GetCartQuery.Data.Cart.Cost.CheckoutChargeAmount) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: GetCartQuery.Data.Cart.Lines.Edge.Node.Cost.TotalAmount) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: GetCartQuery.Data.Cart.Lines.Edge.Node.Cost.AmountPerQuantity) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: GetCartQuery.Data.Cart.Lines.Edge.Node.Cost.CompareAtAmountPerQuantity) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: GetCartQuery.Data.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Price) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: GetCartQuery.Data.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.CompareAtPrice) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: AddCartLinesMutation.Data.CartLinesAdd.Cart.Cost.SubtotalAmount) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: AddCartLinesMutation.Data.CartLinesAdd.Cart.Cost.TotalAmount) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: AddCartLinesMutation.Data.CartLinesAdd.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Price) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: UpdateCartLinesMutation.Data.CartLinesUpdate.Cart.Cost.SubtotalAmount) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: UpdateCartLinesMutation.Data.CartLinesUpdate.Cart.Cost.TotalAmount) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: RemoveCartLinesMutation.Data.CartLinesRemove.Cart.Cost.SubtotalAmount) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: RemoveCartLinesMutation.Data.CartLinesRemove.Cart.Cost.TotalAmount) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: ApplyDiscountCodeMutation.Data.CartDiscountCodesUpdate.Cart.Cost.SubtotalAmount) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }

    init(money: ApplyDiscountCodeMutation.Data.CartDiscountCodesUpdate.Cart.Cost.TotalAmount) {
        self.init(amount: money.amount, currencyCode: money.currencyCode.rawValue)
    }
}
