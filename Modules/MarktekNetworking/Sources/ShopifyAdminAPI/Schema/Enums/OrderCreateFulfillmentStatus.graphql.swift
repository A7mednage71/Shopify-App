// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The order's status in terms of fulfilled line items.
public enum OrderCreateFulfillmentStatus: String, EnumType {
  /// Every line item in the order has been fulfilled.
  case fulfilled = "FULFILLED"
  /// At least one line item in the order has been fulfilled.
  case partial = "PARTIAL"
  /// Every line item in the order has been restocked and the order canceled.
  case restocked = "RESTOCKED"
}
