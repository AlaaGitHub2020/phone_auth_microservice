import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:phone_auth_microservice/app_logic/auth_ui_logic/auth_ui_logic_bloc.dart';
import 'package:phone_auth_microservice/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:phone_auth_microservice/domain/models/auth/auth_failure.dart';
import 'package:phone_auth_microservice/domain/models/auth/i_auth_repository.dart';
import 'package:phone_auth_microservice/domain/models/auth/user_model.dart';
import 'package:phone_auth_microservice/injection.dart';

part 'home_ui_logic_event.dart';

part 'home_ui_logic_state.dart';

part 'home_ui_logic_bloc.freezed.dart';

@injectable
class HomeUiLogicBloc extends Bloc<HomeUiLogicEvent, HomeUiLogicState> {
  HomeUiLogicBloc(this._picker, this._iAuthRepository)
      : super(HomeUiLogicState.myProjects(
            getIt<AuthUiLogicBloc>().state.userModel)) {
    on<HomeUiLogicEvent>(
      (HomeUiLogicEvent event, Emitter<HomeUiLogicState> emit) async {
        await event.map(
          getUser: (_GetUser event) async {
            getLogger().i('getUser Started');

            await _iAuthRepository
                .getUser(userNumber: event.phoneNumber)
                .then((Either<AuthFailure, UserModel> updatedUserOrFailure) {
              updatedUserOrFailure.fold((l) {}, (UserModel updatedUser) {
                emit(state.copyWith(userModel: updatedUser));
              });
            });
          },
          toggleTap: (_ToggleTap event) {
            getLogger().i('toggleTap Started');
            if (event.tabNumber != null) {
              (event.tabNumber == 0)
                  ? emit(HomeUiLogicState.myProjects(state.userModel))
                  : emit(HomeUiLogicState.myAccount(state.userModel));
              return;
            }
            if (state is MyProjectsState) {
              emit(HomeUiLogicState.myAccount(state.userModel));
            } else {
              emit(HomeUiLogicState.myProjects(state.userModel));
            }
          },
          editFamilyPressed: (_EditFamilyPressed event) {
            getLogger().i('editFamilyPressed Started');
            emit(HomeUiLogicState.editFamily(state.userModel));
          },
          editNamePressed: (_EditNamePressed event) {
            getLogger().i('editNamePressed Started');
            emit(HomeUiLogicState.editName(state.userModel));
          },
          updateAvatar: (_UpdateAvatarEvent event) async {
            getLogger().i('updateAvatar Started');
            final XFile? image = await _picker.pickImage(source: event.source);

            emit(state.copyWith(
              userModel: state.userModel.copyWith(photoUrl: image?.path),
            ));

            ///Note: here it's better to upload the image to fireStorage and save the cloud path in the fireStore
            ///But I did it like it just for simplicity
            await _iAuthRepository
                .updateUser(userModel: state.userModel)
                .then((Either<AuthFailure, UserModel> updatedUserOrFailure) {
              updatedUserOrFailure.fold((l) {}, (UserModel updatedUser) {
                emit(state.copyWith(userModel: updatedUser));
              });
            });
          },
          userModelChanged: (_UserModelChangedEvent event) async {
            getLogger().i('userModelChanged Started');
            emit(state.copyWith(userModel: event.userModel));

            await _iAuthRepository
                .updateUser(userModel: state.userModel)
                .then((Either<AuthFailure, UserModel> updatedUserOrFailure) {
              updatedUserOrFailure.fold((l) {}, (UserModel updatedUser) {
                emit(state.copyWith(userModel: updatedUser));
              });
            });
          },
        );
      },
    );
  }

  final ImagePicker _picker;
  final IAuthRepository _iAuthRepository;
}
