import Common

extension CartLine {
    var checkoutProductID: String? {
        variant?.product?.id
    }

    var checkoutProductTitle: String {
        variant?.product?.title ?? CheckoutText.cartItemFallbackTitle
    }

    var checkoutDetailText: String {
        if let colorOption {
            return CheckoutText.colorText(colorOption.value)
        }

        if let title = variant?.title,
           title.lowercased() != CheckoutText.defaultVariantName {
            return title
        }

        return CheckoutText.quantityText(quantity)
    }

    var checkoutImageURL: String? {
        variant?.image?.url
    }

    var checkoutImageAltText: String? {
        variant?.image?.altText
    }

    var checkoutDisplayPrice: CartMoney? {
        cost?.totalAmount ?? variant?.price
    }

    private var colorOption: CartSelectedOption? {
        variant?.selectedOptions.first { option in
            let normalizedName = option.name.lowercased()

            return normalizedName == CheckoutText.colorOptionName || normalizedName == CheckoutText.colourOptionName
        }
    }
}
