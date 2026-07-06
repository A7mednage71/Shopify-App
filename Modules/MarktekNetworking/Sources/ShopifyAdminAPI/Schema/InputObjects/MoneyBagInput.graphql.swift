// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// An input collection of monetary values in their respective currencies.
/// Represents an amount in the shop's currency and the amount as converted to the customer's currency of choice (the presentment currency).
public struct MoneyBagInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    shopMoney: MoneyInput,
    presentmentMoney: GraphQLNullable<MoneyInput> = nil
  ) {
    __data = InputDict([
      "shopMoney": shopMoney,
      "presentmentMoney": presentmentMoney
    ])
  }

  /// Amount in shop currency.
  public var shopMoney: MoneyInput {
    get { __data["shopMoney"] }
    set { __data["shopMoney"] = newValue }
  }

  /// Amount in presentment currency. If this isn't given then we assume that the presentment currency is the same as the shop's currency.
  public var presentmentMoney: GraphQLNullable<MoneyInput> {
    get { __data["presentmentMoney"] }
    set { __data["presentmentMoney"] = newValue }
  }
}
