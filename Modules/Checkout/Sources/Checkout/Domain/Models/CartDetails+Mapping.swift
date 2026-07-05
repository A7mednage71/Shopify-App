import Common
import Foundation

extension CartDetails {
    public func toDraftOrderInput(shippingAddress: CheckoutAddress?) -> DraftOrderCreateInput {
        let items = lines.compactMap { line -> LineItem? in
            guard let variantId = line.variant?.id else { return nil }
            return LineItem(variantId: variantId, quantity: line.quantity)
        }
        return DraftOrderCreateInput(lineItems: items, shippingAddress: shippingAddress)
    }

    public func toDraftOrderDiscountInput() -> DiscountInput? {
        guard let activeDiscountCode = discountCodes.first(where: { $0.applicable }) else {
            return nil
        }
        
        let subtotal = Decimal(string: cost.subtotalAmount.amount.replacingOccurrences(of: ",", with: "")) ?? 0
        let total = Decimal(string: cost.totalAmount.amount.replacingOccurrences(of: ",", with: "")) ?? 0
        let discountValue = subtotal - total
        
        guard discountValue > 0 else {
            return nil
        }
        
        return DiscountInput(
            title: activeDiscountCode.code,
            valueType: .fixedAmount,
            value: Double(truncating: discountValue as NSDecimalNumber)
        )
    }
}
