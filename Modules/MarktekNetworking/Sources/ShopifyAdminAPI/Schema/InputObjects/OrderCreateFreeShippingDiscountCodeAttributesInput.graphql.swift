// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The input fields for a free shipping discount code to apply to an order.
public struct OrderCreateFreeShippingDiscountCodeAttributesInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    code: String
  ) {
    __data = InputDict([
      "code": code
    ])
  }

  /// The discount code that was entered at checkout.
  public var code: String {
    get { __data["code"] }
    set { __data["code"] = newValue }
  }
}
