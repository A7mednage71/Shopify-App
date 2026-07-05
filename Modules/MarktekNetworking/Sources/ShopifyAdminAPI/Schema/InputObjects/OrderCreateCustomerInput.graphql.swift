// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The input fields for a customer to associate with an order. Allows creation of a new customer or specifying an existing one.
public struct OrderCreateCustomerInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    toAssociate: GraphQLNullable<OrderCreateAssociateCustomerAttributesInput> = nil,
    toUpsert: GraphQLNullable<OrderCreateUpsertCustomerAttributesInput> = nil
  ) {
    __data = InputDict([
      "toAssociate": toAssociate,
      "toUpsert": toUpsert
    ])
  }

  /// An existing customer to associate with the order, specified by ID.
  public var toAssociate: GraphQLNullable<OrderCreateAssociateCustomerAttributesInput> {
    get { __data["toAssociate"] }
    set { __data["toAssociate"] = newValue }
  }

  /// A new customer to create or update and associate with the order.
  public var toUpsert: GraphQLNullable<OrderCreateUpsertCustomerAttributesInput> {
    get { __data["toUpsert"] }
    set { __data["toUpsert"] = newValue }
  }
}
