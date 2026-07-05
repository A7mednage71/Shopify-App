// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The input fields for a fixed amount discount code to apply to an order.
public struct OrderCreateFixedDiscountCodeAttributesInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    code: String,
    amountSet: GraphQLNullable<MoneyBagInput> = nil
  ) {
    __data = InputDict([
      "code": code,
      "amountSet": amountSet
    ])
  }

  /// The discount code that was entered at checkout.
  public var code: String {
    get { __data["code"] }
    set { __data["code"] = newValue }
  }

  /// The amount that's deducted from the order total. When you create an order, this value is the monetary amount to deduct.
  public var amountSet: GraphQLNullable<MoneyBagInput> {
    get { __data["amountSet"] }
    set { __data["amountSet"] = newValue }
  }
}
