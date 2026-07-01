import Common
import Foundation

extension CartMoney {
    var checkoutCurrencySymbol: String {
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

    func checkoutFormattedCurrency(fractionDigits: Int = 0) -> String {
        "\(checkoutCurrencySymbol)\(checkoutDecimalText(fractionDigits: fractionDigits))"
    }

    func checkoutSubtracting(_ money: CartMoney, clampedToZero: Bool = false) -> CartMoney {
        let difference = checkoutDecimalValue - money.checkoutDecimalValue
        let amount = clampedToZero && difference < 0 ? 0 : difference

        return CartMoney(amount: NSDecimalNumber(decimal: amount).stringValue, currencyCode: currencyCode)
    }

    var checkoutDecimalValue: Decimal {
        Decimal(string: amount.replacingOccurrences(of: ",", with: "")) ?? 0
    }

    private func checkoutDecimalText(fractionDigits: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits

        return formatter.string(from: NSDecimalNumber(decimal: checkoutDecimalValue)) ?? amount
    }
}
