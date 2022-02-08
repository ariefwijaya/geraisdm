import '../core/settings/models/api_error_model.dart';

/// List of available Error Codes derived from this app (Front end)
class FrontendErrors {
  FrontendErrors._();

  /// Return ERROR when platform is not supported by this apps
  static ApiErrorModel get unknownPlatform =>
      const ApiErrorModel(errorCode: "UNKNOWN_PLATFORM");
  static ApiErrorModel get apiUnknownError =>
      const ApiErrorModel(errorCode: "API_UNKNOWN_ERROR");
  static ApiErrorModel get apiConnectionTimeout =>
      const ApiErrorModel(errorCode: "API_CONNECTION_TIMEOUT");
  static ApiErrorModel get apiErrorData =>
      const ApiErrorModel(errorCode: "API_ERROR_DATA");
  static ApiErrorModel get apiNotSuccess =>
      const ApiErrorModel(errorCode: "API_NOT_SUCCESS");
  static ApiErrorModel get siginAborted =>
      const ApiErrorModel(errorCode: "SIGNIN_ABORTED");
  static ApiErrorModel get sessionInvalid =>
      const ApiErrorModel(errorCode: "SESSION_INVALID");
}

/// List of available Error Codes derived from backend
class BackendErrors {
  BackendErrors._();
  static ApiErrorModel get unknown => const ApiErrorModel(errorCode: "UNKNOWN");
  static ApiErrorModel get unauthorized =>
      const ApiErrorModel(errorCode: "UNAUTHORIZED");
  static ApiErrorModel get dataNotFound =>
      const ApiErrorModel(errorCode: "DATA_NOT_FOUND");
  static ApiErrorModel get badRequest =>
      const ApiErrorModel(errorCode: "BAD_REQUEST");
  static ApiErrorModel get internalServerError =>
      const ApiErrorModel(errorCode: "INTERNAL_SERVER_ERROR");
  static ApiErrorModel get refreshTokenInvalid =>
      const ApiErrorModel(errorCode: "REFRESH_TOKEN_INVALID");

  //Login
  static ApiErrorModel get loginWrongAccess =>
      const ApiErrorModel(errorCode: "WRONG_PASSWORD");
  static ApiErrorModel get loginBadRequest =>
      const ApiErrorModel(errorCode: "BAD_REQUEST");
  static ApiErrorModel get loginNotRegistered =>
      const ApiErrorModel(errorCode: "NOT_REGISTERED");
  static ApiErrorModel get loginDuplicatedRequest =>
      const ApiErrorModel(errorCode: "DUPLICATED_REQUEST");

//Register Request OTP
  static ApiErrorModel get registerUserAlreadyRegistered =>
      const ApiErrorModel(errorCode: "ALREADY_REGISTERED");
  static ApiErrorModel get registerPhoneUsed =>
      const ApiErrorModel(errorCode: "PHONE_HAS_BEEN_USED");
  static ApiErrorModel get registerInvalidNRP =>
      const ApiErrorModel(errorCode: "INVALID_NRP");
  static ApiErrorModel get registerInvalidNIK =>
      const ApiErrorModel(errorCode: "INVALID_NIK");

  //Register Activation
  static ApiErrorModel get registerActivationWrongOTP =>
      const ApiErrorModel(errorCode: "OTP_WRONG");
  static ApiErrorModel get registerActivationExpiredOTP =>
      const ApiErrorModel(errorCode: "OTP_EXPIRED");
  static ApiErrorModel get registerActivationBadRequest =>
      const ApiErrorModel(errorCode: "BAD_REQUEST");

  static ApiErrorModel get registerActivationWrongBirthday =>
      const ApiErrorModel(errorCode: "BIRTHDAY_WRONG");

  static ApiErrorModel get forgotPasswordUserNotValid =>
      const ApiErrorModel(errorCode: "USER_NOT_FOUND");

  static ApiErrorModel get forgotPasswordConfirmWrongOTP =>
      const ApiErrorModel(errorCode: "OTP_WRONG");

  static ApiErrorModel get forgotPasswordConfirmExpiredOTP =>
      const ApiErrorModel(errorCode: "OTP_EXPIRED");
}
