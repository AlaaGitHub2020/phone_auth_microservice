part of 'home_ui_logic_bloc.dart';

@freezed
class HomeUiLogicState with _$HomeUiLogicState {
  const factory HomeUiLogicState.myProjects(UserModel userModel) =
      MyProjectsState;

  const factory HomeUiLogicState.myAccount(UserModel userModel) =
      MyAccountState;

  const factory HomeUiLogicState.editName(UserModel userModel) = EditNameState;

  const factory HomeUiLogicState.editFamily(UserModel userModel) =
      EditFamilyState;
}
