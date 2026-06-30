extension CartLine {
    var productTitle: String {
        variant?.product?.title ?? variant?.title ?? CartText.cartItemFallbackTitle
    }

    var optionText: String? {
        let selectedOptions = variant?.selectedOptions ?? []
        let prioritizedOptions = [
            selectedOptions.first(where: \.isColorOption),
            selectedOptions.first(where: \.isSizeOption)
        ].compactMap { $0 }

        if !prioritizedOptions.isEmpty {
            return CartText.optionsText(
                prioritizedOptions.map { CartText.optionText(name: $0.name, value: $0.value) }
            )
        }

        if let option = selectedOptions.first {
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

private extension CartSelectedOption {
    var isColorOption: Bool {
        name.localizedCaseInsensitiveContains(CartText.colorOptionName)
            || name.localizedCaseInsensitiveContains(CartText.colourOptionName)
    }

    var isSizeOption: Bool {
        name.localizedCaseInsensitiveContains(CartText.sizeOptionName)
    }
}
