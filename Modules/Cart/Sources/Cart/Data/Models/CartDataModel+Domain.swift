extension CartDataModel {
    func toDomain() -> CartDetails {
        CartDetails(
            id: id,
            checkoutUrl: checkoutUrl,
            totalQuantity: totalQuantity ?? lines.reduce(0) { $0 + $1.quantity },
            discountCodes: discountCodes.map { $0.toDomain() },
            cost: cost.toDomain(),
            lines: lines.map { $0.toDomain() }
        )
    }
}

private extension CartDiscountCodeDataModel {
    func toDomain() -> CartDiscountCode {
        CartDiscountCode(code: code, applicable: applicable)
    }
}

private extension CartCostDataModel {
    func toDomain() -> CartCost {
        CartCost(
            subtotalAmount: subtotalAmount.toDomain(),
            totalAmount: totalAmount.toDomain(),
            totalTaxAmount: totalTaxAmount?.toDomain(),
            checkoutChargeAmount: checkoutChargeAmount?.toDomain()
        )
    }
}

private extension CartMoneyDataModel {
    func toDomain() -> CartMoney {
        CartMoney(amount: amount, currencyCode: currencyCode)
    }
}

private extension CartLineDataModel {
    func toDomain() -> CartLine {
        CartLine(
            id: id,
            quantity: quantity,
            cost: cost?.toDomain(),
            variant: variant?.toDomain()
        )
    }
}

private extension CartLineCostDataModel {
    func toDomain() -> CartLineCost {
        CartLineCost(
            totalAmount: totalAmount?.toDomain(),
            amountPerQuantity: amountPerQuantity?.toDomain(),
            compareAtAmountPerQuantity: compareAtAmountPerQuantity?.toDomain()
        )
    }
}

private extension CartProductVariantDataModel {
    func toDomain() -> CartProductVariant {
        CartProductVariant(
            id: id,
            title: title,
            price: price?.toDomain(),
            compareAtPrice: compareAtPrice?.toDomain(),
            availableForSale: availableForSale,
            quantityAvailable: quantityAvailable,
            selectedOptions: selectedOptions.map { $0.toDomain() },
            image: image?.toDomain(),
            product: product?.toDomain()
        )
    }
}

private extension CartSelectedOptionDataModel {
    func toDomain() -> CartSelectedOption {
        CartSelectedOption(name: name, value: value)
    }
}

private extension CartVariantImageDataModel {
    func toDomain() -> CartVariantImage {
        CartVariantImage(url: url, altText: altText)
    }
}

private extension CartProductSummaryDataModel {
    func toDomain() -> CartProductSummary {
        CartProductSummary(id: id, title: title, vendor: vendor)
    }
}

extension CartUserErrorDataModel {
    func toDomain() -> CartUserError {
        CartUserError(code: code, field: field, message: message)
    }
}
