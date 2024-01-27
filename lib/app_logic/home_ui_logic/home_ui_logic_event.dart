part of 'home_ui_logic_bloc.dart';

@freezed
class HomeUiLogicEvent with _$HomeUiLogicEvent {
  const factory HomeUiLogicEvent.getUser({required String phoneNumber}) = _GetUser;

  const factory HomeUiLogicEvent.toggleTap({int? tabNumber}) = _ToggleTap;

  const factory HomeUiLogicEvent.editNamePressed() = _EditNamePressed;

  const factory HomeUiLogicEvent.editFamilyPressed() = _EditFamilyPressed;

  const factory HomeUiLogicEvent.updateAvatar(ImageSource source) =
      _UpdateAvatarEvent;

  const factory HomeUiLogicEvent.userModelChanged(UserModel userModel) =
      _UserModelChangedEvent;
}
