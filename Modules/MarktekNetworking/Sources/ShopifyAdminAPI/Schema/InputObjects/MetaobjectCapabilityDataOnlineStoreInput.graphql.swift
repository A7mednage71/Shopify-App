// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The input fields for the Online Store capability to control renderability on the Online Store.
public struct MetaobjectCapabilityDataOnlineStoreInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    templateSuffix: GraphQLNullable<String> = nil
  ) {
    __data = InputDict([
      "templateSuffix": templateSuffix
    ])
  }

  /// The theme template used when viewing the metaobject in a store.
  public var templateSuffix: GraphQLNullable<String> {
    get { __data["templateSuffix"] }
    set { __data["templateSuffix"] = newValue }
  }
}
