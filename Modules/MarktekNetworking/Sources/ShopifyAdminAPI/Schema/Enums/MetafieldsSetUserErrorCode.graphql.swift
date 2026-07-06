// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// Possible error codes that can be returned by `MetafieldsSetUserError`.
public enum MetafieldsSetUserErrorCode: String, EnumType {
  /// The metafield violates a capability restriction.
  case capabilityViolation = "CAPABILITY_VIOLATION"
  /// The metafield has been modified since it was loaded.
  case staleObject = "STALE_OBJECT"
  /// The compareDigest is invalid.
  case invalidCompareDigest = "INVALID_COMPARE_DIGEST"
  /// The type is invalid.
  case invalidType = "INVALID_TYPE"
  /// The value is invalid for the metafield type or for the definition options.
  case invalidValue = "INVALID_VALUE"
  /// ApiPermission metafields can only be created or updated by the app owner.
  case appNotAuthorized = "APP_NOT_AUTHORIZED"
  /// The input value isn't included in the list.
  case inclusion = "INCLUSION"
  /// The input value is already taken.
  case taken = "TAKEN"
  /// The input value needs to be blank.
  case present = "PRESENT"
  /// The input value is blank.
  case blank = "BLANK"
  /// The input value is too long.
  case tooLong = "TOO_LONG"
  /// The input value is too short.
  case tooShort = "TOO_SHORT"
  /// The input value should be less than or equal to the maximum value allowed.
  case lessThanOrEqualTo = "LESS_THAN_OR_EQUAL_TO"
  /// The input value is invalid.
  case invalid = "INVALID"
  /// An internal error occurred.
  case internalError = "INTERNAL_ERROR"
}
