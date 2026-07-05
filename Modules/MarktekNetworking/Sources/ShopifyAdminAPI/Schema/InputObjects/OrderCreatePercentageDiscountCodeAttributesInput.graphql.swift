// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The input fields for a percentage discount code to apply to an order.
public struct OrderCreatePercentageDiscountCodeAttributesInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    code: String,
    percentage: GraphQLNullable<Double> = nil
  ) {
    __data = InputDict([
      "code": code,
      "percentage": percentage
    ])
  }

  /// The discount code that was entered at checkout.
  public var code: String {
    get { __data["code"] }
    set { __data["code"] = newValue }
  }

  /// The amount that's deducted from the order total. When you create an order, this value is the percentage to deduct.
  public var percentage: GraphQLNullable<Double> {
    get { __data["percentage"] }
    set { __data["percentage"] = newValue }
  }
}
