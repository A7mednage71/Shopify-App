// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The input fields for publishable capability to adjust visibility on channels.
public struct MetaobjectCapabilityDataPublishableInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    status: GraphQLEnum<MetaobjectStatus>
  ) {
    __data = InputDict([
      "status": status
    ])
  }

  /// The visibility status of this metaobject across all channels.
  public var status: GraphQLEnum<MetaobjectStatus> {
    get { __data["status"] }
    set { __data["status"] = newValue }
  }
}
