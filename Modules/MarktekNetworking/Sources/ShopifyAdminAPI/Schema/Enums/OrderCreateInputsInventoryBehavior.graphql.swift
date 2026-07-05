// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The types of behavior to use when updating inventory.
public enum OrderCreateInputsInventoryBehavior: String, EnumType {
  /// Do not claim inventory.
  case bypass = "BYPASS"
  /// Ignore the product's inventory policy and claim inventory.
  case decrementIgnoringPolicy = "DECREMENT_IGNORING_POLICY"
  /// Follow the product's inventory policy and claim inventory, if possible.
  case decrementObeyingPolicy = "DECREMENT_OBEYING_POLICY"
}
