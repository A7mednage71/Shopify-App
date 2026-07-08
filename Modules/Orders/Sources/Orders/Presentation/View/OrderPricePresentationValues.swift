import Foundation

extension String {
    var orderPriceViewValue: Double {
        Double(replacingOccurrences(of: ",", with: "")) ?? 0
    }
}
