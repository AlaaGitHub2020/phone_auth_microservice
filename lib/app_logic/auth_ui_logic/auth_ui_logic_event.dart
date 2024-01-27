part of 'auth_ui_logic_bloc.dart';

@freezed
class AuthUiLogicEvent with _$AuthUiLogicEvent {
  const factory AuthUiLogicEvent.userModelChanged(UserModel userModel) =
      _UserModelEvent;

  const factory AuthUiLogicEvent.stepChanged(int stepNumber) =
      _StepChangedEvent;

  factory AuthUiLogicEvent.smsCodeTimerTick(int secondsRemaining) =
      _SmsCodeTimerTick;

  const factory AuthUiLogicEvent.sendCodePressed() = _SendCodePressed;

  const factory AuthUiLogicEvent.reSendCodePressed() = _ReSendCodePressed;

  const factory AuthUiLogicEvent.smsCodeFilled() = _SmsCodeFilled;

  const factory AuthUiLogicEvent.verifyingPhoneNumber() = _VerifyingPhoneNumber;
}
