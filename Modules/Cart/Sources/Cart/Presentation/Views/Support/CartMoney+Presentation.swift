import Foundation

extension CartMoney {
    var currencySymbol: String {
        switch currencyCode.uppercased() {
        case "USD":
            return "$"
        case "EUR":
            return "€"
        case "GBP":
            return "£"
        case "INR":
            return "₹"
        case "":
            return "$"
        default:
            return currencyCode
        }
    }

    func formattedCurrency(fractionDigits: Int) -> String {
        "\(currencySymbol)\(decimalText(fractionDigits: fractionDigits))"
    }

    func decimalText(fractionDigits: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits

        return formatter.string(from: NSDecimalNumber(decimal: decimalValue)) ?? amount
    }

    func multiplied(by quantity: Int) -> CartMoney {
        let total = decimalValue * Decimal(quantity)

        return CartMoney(amount: NSDecimalNumber(decimal: total).stringValue, currencyCode: currencyCode)
    }

    func subtracting(_ money: CartMoney, clampedToZero: Bool = false) -> CartMoney {
        let difference = decimalValue - money.decimalValue
        let amount = clampedToZero && difference < 0 ? 0 : difference

        return CartMoney(amount: NSDecimalNumber(decimal: amount).stringValue, currencyCode: currencyCode)
    }

    var decimalValue: Decimal {
        Decimal(string: amount.replacingOccurrences(of: ",", with: "")) ?? 0
    }

    var priceViewValue: Double {
        NSDecimalNumber(decimal: decimalValue).doubleValue
    }
}
