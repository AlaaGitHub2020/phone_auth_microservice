part of 'home_ui_logic_bloc.dart';

@freezed
class HomeUiLogicState with _$HomeUiLogicState {
  const factory HomeUiLogicState.myProjects() = _MyProjects;

  const factory HomeUiLogicState.myAccount() = _MyAccount;

  const factory HomeUiLogicState.editName() = _EditName;

  const factory HomeUiLogicState.editFamily() = _EditFamily;
}
