import Common
import Foundation

extension CartMoney {
    var checkoutPriceViewValue: Double {
        NSDecimalNumber(decimal: checkoutDecimalValue).doubleValue
    }
}

extension Decimal {
    var checkoutPriceViewValue: Double {
        NSDecimalNumber(decimal: self).doubleValue
    }
}
