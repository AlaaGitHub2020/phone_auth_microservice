// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:image_picker/image_picker.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:phone_auth_microservice/app_logic/auth_ui_logic/auth_ui_logic_bloc.dart'
    as _i8;
import 'package:phone_auth_microservice/app_logic/home_ui_logic/home_ui_logic_bloc.dart'
    as _i9;
import 'package:phone_auth_microservice/domain/models/auth/i_auth_repository.dart'
    as _i5;
import 'package:phone_auth_microservice/infrastructure/core/infrastructure_injectable_module.dart'
    as _i10;
import 'package:phone_auth_microservice/infrastructure/repositories/auth/auth_repository.dart'
    as _i6;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final infrastructureInjectableModule = _$InfrastructureInjectableModule();
    gh.lazySingleton<_i3.FirebaseAuth>(
        () => infrastructureInjectableModule.firebaseAuth);
    gh.lazySingleton<_i4.FirebaseFirestore>(
        () => infrastructureInjectableModule.fireStore);
    gh.lazySingleton<_i5.IAuthRepository>(() => _i6.AuthRepository(
          gh<_i3.FirebaseAuth>(),
          gh<_i4.FirebaseFirestore>(),
        ));
    gh.lazySingleton<_i7.ImagePicker>(
        () => infrastructureInjectableModule.picker);
    gh.factory<_i8.AuthUiLogicBloc>(() => _i8.AuthUiLogicBloc(
          gh<_i5.IAuthRepository>(),
          gh<_i3.FirebaseAuth>(),
        ));
    gh.factory<_i9.HomeUiLogicBloc>(() => _i9.HomeUiLogicBloc(
          gh<_i7.ImagePicker>(),
          gh<_i5.IAuthRepository>(),
        ));
    return this;
  }
}

class _$InfrastructureInjectableModule
    extends _i10.InfrastructureInjectableModule {}
