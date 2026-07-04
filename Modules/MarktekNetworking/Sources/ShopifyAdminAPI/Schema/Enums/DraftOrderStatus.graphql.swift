// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The valid statuses for a draft order.
public enum DraftOrderStatus: String, EnumType {
  /// The draft order has been paid.
  case completed = "COMPLETED"
  /// An invoice for the draft order has been sent to the customer.
  case invoiceSent = "INVOICE_SENT"
  /// The draft order is open. It has not been paid, and an invoice hasn't been sent.
  case open = "OPEN"
}
