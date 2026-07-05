// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The input fields for a line item property for an order.
public struct OrderCreateLineItemPropertyInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    name: String,
    value: String
  ) {
    __data = InputDict([
      "name": name,
      "value": value
    ])
  }

  /// The name of the line item property.
  public var name: String {
    get { __data["name"] }
    set { __data["name"] = newValue }
  }

  /// The value of the line item property.
  public var value: String {
    get { __data["value"] }
    set { __data["value"] = newValue }
  }
}
