// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension Objects {
  /// Information about a customer of the shop, such as the customer's contact details, purchase history, and marketing preferences.
  ///
  /// Tracks the customer's total spending through the [`amountSpent`](https://shopify.dev/docs/api/admin-graphql/latest/objects/Customer#field-amountSpent) field and provides access to associated data such as payment methods and subscription contracts.
  ///
  /// > Caution:
  /// > Only use this data if it's required for your app's functionality. Shopify will restrict [access to scopes](https://shopify.dev/api/usage/access-scopes) for apps that don't have a legitimate use for the associated data.
  nonisolated static let Customer = ApolloAPI.Object(
    typename: "Customer",
    implementedInterfaces: [
      Interfaces.CommentEventSubject.self,
      Interfaces.HasEvents.self,
      Interfaces.HasMetafieldDefinitions.self,
      Interfaces.HasMetafields.self,
      Interfaces.HasStoreCreditAccounts.self,
      Interfaces.LegacyInteroperability.self,
      Interfaces.Node.self
    ],
    keyFields: nil
  )
}