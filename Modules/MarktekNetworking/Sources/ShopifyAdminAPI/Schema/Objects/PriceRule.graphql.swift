// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension Objects {
  /// A set of conditions, including entitlements and prerequisites, that must be met for a discount code to apply.
  ///
  /// > Note:
  /// > Use the types and queries included our [discount tutorials](https://shopify.dev/docs/apps/selling-strategies/discounts/getting-started) instead. These will replace the GraphQL Admin API's [`PriceRule`](https://shopify.dev/docs/api/admin-graphql/latest/objects/PriceRule) object and [`DiscountCode`](https://shopify.dev/docs/api/admin-graphql/latest/unions/DiscountCode) union, and the REST Admin API's deprecated[`PriceRule`](https://shopify.dev/docs/api/admin-rest/unstable/resources/pricerule) resource.
  static let PriceRule = Object(
    typename: "PriceRule",
    implementedInterfaces: [
      Interfaces.CommentEventSubject.self,
      Interfaces.HasEvents.self,
      Interfaces.LegacyInteroperability.self,
      Interfaces.Node.self
    ]
  )
}