// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension Objects {
  /// A standalone content page in the online store. Pages display HTML-formatted content for informational pages like "About Us", contact information, or shipping policies.
  ///
  /// Each page has a unique handle for URL routing and supports custom template suffixes for specialized layouts. Pages can be published or hidden, and include creation and update timestamps.
  nonisolated static let Page = ApolloAPI.Object(
    typename: "Page",
    implementedInterfaces: [
      Interfaces.HasEvents.self,
      Interfaces.HasMetafieldDefinitions.self,
      Interfaces.HasMetafields.self,
      Interfaces.HasPublishedTranslations.self,
      Interfaces.Navigable.self,
      Interfaces.Node.self
    ],
    keyFields: nil
  )
}