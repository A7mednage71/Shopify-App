// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The different kinds of order transactions.
public enum OrderTransactionKind: String, EnumType {
  /// An authorization and capture performed together in a single step.
  case sale = "SALE"
  /// A transfer of the money that was reserved by an authorization.
  case capture = "CAPTURE"
  /// An amount reserved against the cardholder's funding source.
  /// Money does not change hands until the authorization is captured.
  case authorization = "AUTHORIZATION"
  /// A cancelation of an authorization transaction.
  case void = "VOID"
  /// A partial or full return of captured funds to the cardholder.
  /// A refund can happen only after a capture is processed.
  case refund = "REFUND"
  /// The money returned to the customer when they've paid too much during a cash transaction.
  case change = "CHANGE"
  /// An authorization for a payment taken with an EMV credit card reader.
  case emvAuthorization = "EMV_AUTHORIZATION"
  /// A suggested refund transaction that can be used to create a refund.
  case suggestedRefund = "SUGGESTED_REFUND"
}
