// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension Objects {
  /// Defines quantity-based discount rules that specify how many items are eligible for a discount effect. This object enables bulk purchase incentives and tiered pricing strategies.
  ///
  /// For example, a "Buy 4 candles, get 2 candles 50% off (mix and match)" promotion would specify a quantity threshold of 2 items that will receive a percentage discount effect, encouraging customers to purchase more items to unlock savings.
  ///
  /// The configuration combines quantity requirements with discount effects, allowing merchants to create sophisticated pricing rules that reward larger purchases and increase average order values.
  static let DiscountOnQuantity = Object(
    typename: "DiscountOnQuantity",
    implementedInterfaces: []
  )
}