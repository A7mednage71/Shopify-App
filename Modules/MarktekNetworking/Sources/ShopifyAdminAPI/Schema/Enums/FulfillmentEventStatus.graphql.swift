// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The status that describes a fulfillment or delivery event.
public enum FulfillmentEventStatus: String, EnumType {
  /// A shipping label has been purchased.
  case labelPurchased = "LABEL_PURCHASED"
  /// A purchased shipping label has been printed.
  case labelPrinted = "LABEL_PRINTED"
  /// The fulfillment is ready to be picked up.
  case readyForPickup = "READY_FOR_PICKUP"
  /// The fulfillment is confirmed. This is the default value when no other information is available.
  case confirmed = "CONFIRMED"
  /// The fulfillment is in transit.
  case inTransit = "IN_TRANSIT"
  /// The fulfillment is out for delivery.
  case outForDelivery = "OUT_FOR_DELIVERY"
  /// A delivery was attempted.
  case attemptedDelivery = "ATTEMPTED_DELIVERY"
  /// The fulfillment is delayed.
  case delayed = "DELAYED"
  /// The fulfillment was successfully delivered.
  case delivered = "DELIVERED"
  /// The fulfillment request failed.
  case failure = "FAILURE"
}
