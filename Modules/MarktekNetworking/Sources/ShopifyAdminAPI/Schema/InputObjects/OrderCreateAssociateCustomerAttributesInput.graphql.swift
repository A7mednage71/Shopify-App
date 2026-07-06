// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The input fields for identifying an existing customer to associate with the order.
public struct OrderCreateAssociateCustomerAttributesInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    id: GraphQLNullable<ID> = nil,
    email: GraphQLNullable<String> = nil
  ) {
    __data = InputDict([
      "id": id,
      "email": email
    ])
  }

  /// The customer to associate to the order.
  public var id: GraphQLNullable<ID> {
    get { __data["id"] }
    set { __data["id"] = newValue }
  }

  /// The email of the customer to associate to the order.
  ///
  ///               > Note:
  ///               > If both this email input field and the email on `OrderCreateOrderInput` are provided, this field will
  ///               > take precedence.
  public var email: GraphQLNullable<String> {
    get { __data["email"] }
    set { __data["email"] = newValue }
  }
}
