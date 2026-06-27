// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension Interfaces {
  /// An interface representing asynchronous operations on products. Tracks the status and details of background product mutations like `productSet`, `productDelete`, `productDuplicate`, and `productBundle` operations. Provides status field (CREATED, ACTIVE, COMPLETE) and product field to monitor long-running product operations.
  nonisolated static let ProductOperation = ApolloAPI.Interface(
    name: "ProductOperation",
    keyFields: nil,
    implementingObjects: [
      "ProductBundleOperation",
      "ProductDeleteOperation",
      "ProductDuplicateOperation",
      "ProductSetOperation"
    ]
  )
}