part of 'auth_ui_logic_bloc.dart';

@freezed
class AuthUiLogicState with _$AuthUiLogicState {
  const factory AuthUiLogicState.firstStep(UserModel userModel) = _FirstStep;

  const factory AuthUiLogicState.secondStep(
          UserModel userModel, int timer, TextEditingController controller) =
      _SecondStep;

  const factory AuthUiLogicState.thirdStep(UserModel userModel) = _ThirdStep;

  const factory AuthUiLogicState.authorizedUser(UserModel userModel) =
      _AuthorizedUser;

  const factory AuthUiLogicState.errorState(UserModel userModel,
      AuthFailure failure, TextEditingController controller) = ErrorState;
}
