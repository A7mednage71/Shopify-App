extension CartLine {
    var productTitle: String {
        variant?.product?.title ?? variant?.title ?? CartText.cartItemFallbackTitle
    }

    var optionText: String? {
        if let colorOption = variant?.selectedOptions.first(where: { $0.name.localizedCaseInsensitiveContains(CartText.colorOptionName) }) {
            return CartText.optionText(name: colorOption.name, value: colorOption.value)
        }

        if let option = variant?.selectedOptions.first {
            return CartText.optionText(name: option.name, value: option.value)
        }

        guard let title = variant?.title,
              !title.localizedCaseInsensitiveContains(CartText.defaultVariantName) else {
            return nil
        }

        return CartText.variantText(title: title)
    }

    var displayMoney: CartMoney? {
        if let unitMoney = cost?.amountPerQuantity ?? variant?.price {
            return unitMoney.multiplied(by: quantity)
        }

        return cost?.totalAmount
    }
}
