// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension Objects {
  /// An error in the input of a mutation. Mutations return `UserError` objects to indicate validation failures, such as invalid field values or business logic violations, that prevent the operation from completing.
  static let UserError = Object(
    typename: "UserError",
    implementedInterfaces: [Interfaces.DisplayableError.self]
  )
}