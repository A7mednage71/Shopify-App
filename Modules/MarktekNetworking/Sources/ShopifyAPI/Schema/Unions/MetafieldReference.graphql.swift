// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension Unions {
  /// The resource that a metafield points to when its type is a resource reference. Metafields can store references to other Shopify resources, and this union provides access to the actual referenced object.
  ///
  /// Returned by the `Metafield` object's [`reference`](https://shopify.dev/docs/api/storefront/current/objects/Metafield#field-Metafield.fields.reference) field for single references or the [`references`](https://shopify.dev/docs/api/storefront/current/objects/Metafield#field-Metafield.fields.references) field for lists.
  ///
  static let MetafieldReference = Union(
    name: "MetafieldReference",
    possibleTypes: [
      Objects.Collection.self,
      Objects.GenericFile.self,
      Objects.MediaImage.self,
      Objects.Metaobject.self,
      Objects.Model3d.self,
      Objects.Page.self,
      Objects.Product.self,
      Objects.ProductVariant.self,
      Objects.Video.self
    ]
  )
}