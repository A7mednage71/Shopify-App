// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

/// Possible error codes that can be returned by `MetaobjectUserError`.
public enum MetaobjectUserErrorCode: String, EnumType {
  /// The input value is invalid.
  case invalid = "INVALID"
  /// The input value isn't included in the list.
  case inclusion = "INCLUSION"
  /// The input value is already taken.
  case taken = "TAKEN"
  /// The input value is too long.
  case tooLong = "TOO_LONG"
  /// The input value is too short.
  case tooShort = "TOO_SHORT"
  /// The input value needs to be blank.
  case present = "PRESENT"
  /// The input value is blank.
  case blank = "BLANK"
  /// The metafield type is invalid.
  case invalidType = "INVALID_TYPE"
  /// The value is invalid for the metafield type or the definition options.
  case invalidValue = "INVALID_VALUE"
  /// The value for the metafield definition option was invalid.
  case invalidOption = "INVALID_OPTION"
  /// Duplicate inputs were provided for this field key.
  case duplicateFieldInput = "DUPLICATE_FIELD_INPUT"
  /// No metaobject definition found for this type.
  case undefinedObjectType = "UNDEFINED_OBJECT_TYPE"
  /// No field definition found for this key.
  case undefinedObjectField = "UNDEFINED_OBJECT_FIELD"
  /// The specified field key is already in use.
  case objectFieldTaken = "OBJECT_FIELD_TAKEN"
  /// Missing required fields were found for this object.
  case objectFieldRequired = "OBJECT_FIELD_REQUIRED"
  /// The requested record couldn't be found.
  case recordNotFound = "RECORD_NOT_FOUND"
  /// An unexpected error occurred.
  case internalError = "INTERNAL_ERROR"
  /// The maximum number of metaobjects definitions has been exceeded.
  case maxDefinitionsExceeded = "MAX_DEFINITIONS_EXCEEDED"
  /// The maximum number of metaobjects per shop has been exceeded.
  case maxObjectsExceeded = "MAX_OBJECTS_EXCEEDED"
  /// The maximum number of input metaobjects has been exceeded.
  case inputLimitExceeded = "INPUT_LIMIT_EXCEEDED"
  /// The targeted object cannot be modified.
  case immutable = "IMMUTABLE"
  /// Not authorized.
  case notAuthorized = "NOT_AUTHORIZED"
  /// The provided name is reserved for system use.
  case reservedName = "RESERVED_NAME"
  /// The display name cannot be the same when using the metaobject as a product option.
  case displayNameConflict = "DISPLAY_NAME_CONFLICT"
  /// Admin access can only be specified on metaobject definitions that have an app-reserved type.
  case adminAccessInputNotAllowed = "ADMIN_ACCESS_INPUT_NOT_ALLOWED"
  /// Definition is managed by app configuration and cannot be modified through the API.
  case appConfigManaged = "APP_CONFIG_MANAGED"
  /// Definition is required by an installed app and cannot be deleted.
  case standardMetaobjectDefinitionDependentOnApp = "STANDARD_METAOBJECT_DEFINITION_DEPENDENT_ON_APP"
  /// The capability you are using is not enabled.
  case capabilityNotEnabled = "CAPABILITY_NOT_ENABLED"
  /// The Online Store URL handle is already taken.
  case urlHandleTaken = "URL_HANDLE_TAKEN"
  /// The Online Store URL handle is invalid.
  case urlHandleInvalid = "URL_HANDLE_INVALID"
  /// The Online Store URL handle cannot be blank.
  case urlHandleBlank = "URL_HANDLE_BLANK"
  /// Renderable data input is referencing an invalid field.
  case fieldTypeInvalid = "FIELD_TYPE_INVALID"
  /// The input is missing required keys.
  case missingRequiredKeys = "MISSING_REQUIRED_KEYS"
  /// The action cannot be completed because associated metaobjects are referenced by another resource.
  case referenceExistsError = "REFERENCE_EXISTS_ERROR"
}
