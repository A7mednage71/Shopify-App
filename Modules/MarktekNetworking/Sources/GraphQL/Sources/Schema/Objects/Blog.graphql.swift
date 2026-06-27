// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension Objects {
  /// A blog for publishing articles in the online store. Stores can have multiple blogs to organize content by topic or purpose.
  ///
  /// Each blog contains articles with their associated comments, tags, and metadata. The comment policy controls whether readers can post comments and whether moderation is required. Blogs use customizable URL handles and can apply alternate templates for specialized layouts.
  nonisolated static let Blog = ApolloAPI.Object(
    typename: "Blog",
    implementedInterfaces: [
      Interfaces.HasEvents.self,
      Interfaces.HasMetafieldDefinitions.self,
      Interfaces.HasMetafields.self,
      Interfaces.HasPublishedTranslations.self,
      Interfaces.Node.self
    ],
    keyFields: nil
  )
}