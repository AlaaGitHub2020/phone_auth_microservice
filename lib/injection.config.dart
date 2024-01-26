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
import 'package:injectable/injectable.dart' as _i2;
import 'package:phone_auth_microservice/app_logic/auth_ui_logic/auth_ui_logic_bloc.dart'
    as _i8;
import 'package:phone_auth_microservice/app_logic/home_ui_logic/home_ui_logic_bloc.dart'
    as _i5;
import 'package:phone_auth_microservice/domain/models/auth/i_auth_repository.dart'
    as _i6;
import 'package:phone_auth_microservice/infrastructure/core/infrastructure_injectable_module.dart'
    as _i9;
import 'package:phone_auth_microservice/infrastructure/repositories/auth/auth_repository.dart'
    as _i7;

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
    gh.factory<_i5.HomeUiLogicBloc>(() => _i5.HomeUiLogicBloc());
    gh.lazySingleton<_i6.IAuthRepository>(() => _i7.AuthRepository(
          gh<_i3.FirebaseAuth>(),
          gh<_i4.FirebaseFirestore>(),
        ));
    gh.factory<_i8.AuthUiLogicBloc>(() => _i8.AuthUiLogicBloc(
          gh<_i6.IAuthRepository>(),
          gh<_i3.FirebaseAuth>(),
        ));
    return this;
  }
}

class _$InfrastructureInjectableModule
    extends _i9.InfrastructureInjectableModule {}
