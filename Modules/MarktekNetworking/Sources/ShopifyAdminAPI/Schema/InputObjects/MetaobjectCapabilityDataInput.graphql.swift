// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The input fields for metaobject capabilities.
public struct MetaobjectCapabilityDataInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    publishable: GraphQLNullable<MetaobjectCapabilityDataPublishableInput> = nil,
    onlineStore: GraphQLNullable<MetaobjectCapabilityDataOnlineStoreInput> = nil
  ) {
    __data = InputDict([
      "publishable": publishable,
      "onlineStore": onlineStore
    ])
  }

  /// Publishable capability input.
  public var publishable: GraphQLNullable<MetaobjectCapabilityDataPublishableInput> {
    get { __data["publishable"] }
    set { __data["publishable"] = newValue }
  }

  /// Online Store capability input.
  public var onlineStore: GraphQLNullable<MetaobjectCapabilityDataOnlineStoreInput> {
    get { __data["onlineStore"] }
    set { __data["onlineStore"] = newValue }
  }
}
