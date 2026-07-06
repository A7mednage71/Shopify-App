// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// Represents the order's current financial status.
public enum OrderDisplayFinancialStatus: String, EnumType {
  /// Displayed as **Pending**. Orders have this status when the payment provider needs time to complete the payment, or when manual payment methods are being used.
  case pending = "PENDING"
  /// Displayed as **Authorized**. The payment provider has validated the customer's payment information. This status appears only for manual payment capture and indicates payments should be captured before the authorization period expires.
  case authorized = "AUTHORIZED"
  /// Displayed as **Partially paid**. A payment was manually captured for the order with an amount less than the full order value.
  case partiallyPaid = "PARTIALLY_PAID"
  /// Displayed as **Partially refunded**. The amount refunded to a customer is less than the full amount paid for an order.
  case partiallyRefunded = "PARTIALLY_REFUNDED"
  /// Displayed as **Voided**. An unpaid (payment authorized but not captured) order was manually
  ///          canceled.
  case voided = "VOIDED"
  /// Displayed as **Paid**. Payment was automatically or manually captured, or the order was marked as paid.
  case paid = "PAID"
  /// Displayed as **Refunded**. The full amount paid for an order was refunded to the customer.
  case refunded = "REFUNDED"
  /// Displayed as **Expired**. Payment wasn't captured before the payment provider's deadline on an authorized order. Some payment providers use this status to indicate failed payment processing.
  case expired = "EXPIRED"
}
