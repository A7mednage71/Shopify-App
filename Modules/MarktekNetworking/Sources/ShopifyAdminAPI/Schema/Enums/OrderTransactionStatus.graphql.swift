// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// The different states that an `OrderTransaction` can have.
public enum OrderTransactionStatus: String, EnumType {
  /// The transaction succeeded.
  case success = "SUCCESS"
  /// The transaction failed.
  case failure = "FAILURE"
  /// The transaction is pending.
  case pending = "PENDING"
  /// There was an error while processing the transaction.
  case error = "ERROR"
  /// Awaiting a response.
  case awaitingResponse = "AWAITING_RESPONSE"
  /// The transaction status is unknown.
  case unknown = "UNKNOWN"
}
