import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:phone_auth_microservice/domain/core/utilities/logger/simple_log_printer.dart';

part 'home_ui_logic_event.dart';

part 'home_ui_logic_state.dart';

part 'home_ui_logic_bloc.freezed.dart';

@injectable
class HomeUiLogicBloc extends Bloc<HomeUiLogicEvent, HomeUiLogicState> {
  HomeUiLogicBloc() : super(const HomeUiLogicState.myProjects()) {
    on<HomeUiLogicEvent>(
        (HomeUiLogicEvent event, Emitter<HomeUiLogicState> emit) {
      event.map(toggleTap: (_ToggleTap event) {
        getLogger().i('toggleTap Started');
        if (event.tabNumber != null) {
          (event.tabNumber == 0)
              ? emit(const HomeUiLogicState.myProjects())
              : emit(const HomeUiLogicState.myAccount());
          return;
        }
        if (state is _MyProjects) {
          emit(const HomeUiLogicState.myAccount());
        } else {
          emit(const HomeUiLogicState.myProjects());
        }
      }, editFamilyPressed: (_EditFamilyPressed event) {
        getLogger().i('editFamilyPressed Started');
        emit(const HomeUiLogicState.editFamily());
      }, editNamePressed: (_EditNamePressed event) {
        getLogger().i('editNamePressed Started');
        emit(const HomeUiLogicState.editName());
      });
    });
  }
}
