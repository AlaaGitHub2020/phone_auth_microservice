import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
abstract class AuthFailure with _$AuthFailure {
  const factory AuthFailure.unexpected() = _Unexpected;

  const factory AuthFailure.verificationNotCompleted() =
      _VerificationNotCompleted;

  const factory AuthFailure.codeAutoRetrievalTimeout() =
      _CodeAutoRetrievalTimeout;

  const factory AuthFailure.firebaseServerFailure() = _FirebaseServerFailure;

  const factory AuthFailure.invalidPhoneNumberFailure() =
      _InvalidPhoneNumberFailure;

  const factory AuthFailure.invalidVerificationCode() =
      _InvalidVerificationCodeFailure;

  const factory AuthFailure.tooManyRequestsFailure() = _TooManyRequestsFailure;

  const factory AuthFailure.verifyPhoneNumberFailure() =
      _VerifyPhoneNumberFailure;

  const factory AuthFailure.fetchCurrentUserFailure() =
      _FetchCurrentUserFailure;

  const factory AuthFailure.waitingForSMSFailure() = _WaitingForSMSFailure;
}
