// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The input fields for a note attribute for an order.
public struct OrderCreateCustomAttributeInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    key: String,
    value: String
  ) {
    __data = InputDict([
      "key": key,
      "value": value
    ])
  }

  /// The key or name of the custom attribute.
  public var key: String {
    get { __data["key"] }
    set { __data["key"] = newValue }
  }

  /// The value of the custom attribute.
  public var value: String {
    get { __data["value"] }
    set { __data["value"] = newValue }
  }
}
