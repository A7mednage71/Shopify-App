// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The input fields for creating a metaobject.
public struct MetaobjectCreateInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    type: String,
    handle: GraphQLNullable<String> = nil,
    fields: GraphQLNullable<[MetaobjectFieldInput]> = nil,
    capabilities: GraphQLNullable<MetaobjectCapabilityDataInput> = nil
  ) {
    __data = InputDict([
      "type": type,
      "handle": handle,
      "fields": fields,
      "capabilities": capabilities
    ])
  }

  /// The type of the metaobject. Must match an existing metaobject definition type.
  public var type: String {
    get { __data["type"] }
    set { __data["type"] = newValue }
  }

  /// A unique handle for the metaobject. This value is auto-generated when omitted.
  public var handle: GraphQLNullable<String> {
    get { __data["handle"] }
    set { __data["handle"] = newValue }
  }

  /// Values for fields. These are mapped by key to fields of the metaobject definition.
  public var fields: GraphQLNullable<[MetaobjectFieldInput]> {
    get { __data["fields"] }
    set { __data["fields"] = newValue }
  }

  /// Capabilities for the metaobject.
  public var capabilities: GraphQLNullable<MetaobjectCapabilityDataInput> {
    get { __data["capabilities"] }
    set { __data["capabilities"] = newValue }
  }
}
