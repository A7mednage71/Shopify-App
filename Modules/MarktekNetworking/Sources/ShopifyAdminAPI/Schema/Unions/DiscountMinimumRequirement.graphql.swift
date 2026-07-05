// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension Unions {
  /// The type of minimum requirement that must be met for the discount to be applied. For example, a customer must spend a minimum subtotal to be eligible for the discount. Alternatively, a customer must purchase a minimum quantity of items to be eligible for the discount.
  static let DiscountMinimumRequirement = Union(
    name: "DiscountMinimumRequirement",
    possibleTypes: [
      Objects.DiscountMinimumQuantity.self,
      Objects.DiscountMinimumSubtotal.self
    ]
  )
}