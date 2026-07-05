// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The input fields that define the strategies for updating inventory and
/// whether to send shipping and order confirmations to customers.
public struct OrderCreateOptionsInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    inventoryBehaviour: GraphQLNullable<GraphQLEnum<OrderCreateInputsInventoryBehavior>>,
    sendReceipt: GraphQLNullable<Bool>,
    sendFulfillmentReceipt: GraphQLNullable<Bool>
  ) {
    __data = InputDict([
      "inventoryBehaviour": inventoryBehaviour,
      "sendReceipt": sendReceipt,
      "sendFulfillmentReceipt": sendFulfillmentReceipt
    ])
  }

  /// The strategy for handling updates to inventory: not claiming inventory, ignoring inventory policies,
  /// or following policies when claiming inventory.
  public var inventoryBehaviour: GraphQLNullable<GraphQLEnum<OrderCreateInputsInventoryBehavior>> {
    get { __data["inventoryBehaviour"] }
    set { __data["inventoryBehaviour"] = newValue }
  }

  /// Whether to send an order confirmation to the customer.
  public var sendReceipt: GraphQLNullable<Bool> {
    get { __data["sendReceipt"] }
    set { __data["sendReceipt"] = newValue }
  }

  /// Whether to send a shipping confirmation to the customer.
  public var sendFulfillmentReceipt: GraphQLNullable<Bool> {
    get { __data["sendFulfillmentReceipt"] }
    set { __data["sendFulfillmentReceipt"] = newValue }
  }
}
