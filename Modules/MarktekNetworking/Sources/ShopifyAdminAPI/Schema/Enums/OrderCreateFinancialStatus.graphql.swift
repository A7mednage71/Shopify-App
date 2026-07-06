// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The status of payments associated with the order. Can only be set when the order is created.
public enum OrderCreateFinancialStatus: String, EnumType {
  /// The payments are pending. Payment might fail in this state. Check again to confirm whether the payments have been paid successfully.
  case pending = "PENDING"
  /// The payments have been authorized.
  case authorized = "AUTHORIZED"
  /// The order has been partially paid.
  case partiallyPaid = "PARTIALLY_PAID"
  /// The payments have been paid.
  case paid = "PAID"
  /// The payments have been partially refunded.
  case partiallyRefunded = "PARTIALLY_REFUNDED"
  /// The payments have been refunded.
  case refunded = "REFUNDED"
  /// The payments have been voided.
  case voided = "VOIDED"
  /// The payments have been expired.
  case expired = "EXPIRED"
}
