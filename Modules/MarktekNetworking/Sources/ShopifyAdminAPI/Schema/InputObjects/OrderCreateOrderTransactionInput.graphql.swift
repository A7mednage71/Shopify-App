// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The input fields for a transaction to create for an order.
public struct OrderCreateOrderTransactionInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    amountSet: MoneyBagInput,
    authorizationCode: GraphQLNullable<String> = nil,
    deviceId: GraphQLNullable<ID> = nil,
    gateway: GraphQLNullable<String> = nil,
    giftCardId: GraphQLNullable<ID> = nil,
    kind: GraphQLNullable<GraphQLEnum<OrderTransactionKind>>,
    locationId: GraphQLNullable<ID> = nil,
    processedAt: GraphQLNullable<DateTime> = nil,
    receiptJson: GraphQLNullable<JSON> = nil,
    status: GraphQLNullable<GraphQLEnum<OrderTransactionStatus>>,
    test: GraphQLNullable<Bool>,
    userId: GraphQLNullable<ID> = nil
  ) {
    __data = InputDict([
      "amountSet": amountSet,
      "authorizationCode": authorizationCode,
      "deviceId": deviceId,
      "gateway": gateway,
      "giftCardId": giftCardId,
      "kind": kind,
      "locationId": locationId,
      "processedAt": processedAt,
      "receiptJson": receiptJson,
      "status": status,
      "test": test,
      "userId": userId
    ])
  }

  /// The amount of the transaction.
  public var amountSet: MoneyBagInput {
    get { __data["amountSet"] }
    set { __data["amountSet"] = newValue }
  }

  /// The authorization code associated with the transaction.
  public var authorizationCode: GraphQLNullable<String> {
    get { __data["authorizationCode"] }
    set { __data["authorizationCode"] = newValue }
  }

  /// The ID of the device used to process the transaction.
  public var deviceId: GraphQLNullable<ID> {
    get { __data["deviceId"] }
    set { __data["deviceId"] = newValue }
  }

  /// The name of the gateway the transaction was issued through.
  public var gateway: GraphQLNullable<String> {
    get { __data["gateway"] }
    set { __data["gateway"] = newValue }
  }

  /// The ID of the gift card used for this transaction.
  public var giftCardId: GraphQLNullable<ID> {
    get { __data["giftCardId"] }
    set { __data["giftCardId"] = newValue }
  }

  /// The kind of transaction.
  public var kind: GraphQLNullable<GraphQLEnum<OrderTransactionKind>> {
    get { __data["kind"] }
    set { __data["kind"] = newValue }
  }

  /// The ID of the location where the transaction was processed.
  public var locationId: GraphQLNullable<ID> {
    get { __data["locationId"] }
    set { __data["locationId"] = newValue }
  }

  /// The date and time when the transaction was processed.
  public var processedAt: GraphQLNullable<DateTime> {
    get { __data["processedAt"] }
    set { __data["processedAt"] = newValue }
  }

  /// The transaction receipt that the payment gateway attaches to the transaction.
  /// The value of this field depends on which payment gateway processed the transaction.
  public var receiptJson: GraphQLNullable<JSON> {
    get { __data["receiptJson"] }
    set { __data["receiptJson"] = newValue }
  }

  /// The status of the transaction.
  public var status: GraphQLNullable<GraphQLEnum<OrderTransactionStatus>> {
    get { __data["status"] }
    set { __data["status"] = newValue }
  }

  /// Whether the transaction is a test transaction.
  public var test: GraphQLNullable<Bool> {
    get { __data["test"] }
    set { __data["test"] = newValue }
  }

  /// The ID of the user who processed the transaction.
  public var userId: GraphQLNullable<ID> {
    get { __data["userId"] }
    set { __data["userId"] = newValue }
  }
}
