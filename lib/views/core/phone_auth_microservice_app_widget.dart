import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_microservice/app_logic/auth_ui_logic/auth_ui_logic_bloc.dart';
import 'package:phone_auth_microservice/app_logic/home_ui_logic/home_ui_logic_bloc.dart';
import 'package:phone_auth_microservice/injection.dart';
import 'package:phone_auth_microservice/views/core/phone_auth_microservice_application.dart';

class PhoneAuthMicroserviceAppWidget extends StatelessWidget {
  ///Constructor
  const PhoneAuthMicroserviceAppWidget({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<AuthUiLogicBloc>(
            create: (_) => getIt<AuthUiLogicBloc>(),
          ),
          BlocProvider<HomeUiLogicBloc>(
            create: (_) => getIt<HomeUiLogicBloc>(),
          ),
        ],
        child: const PhoneAuthMicroserviceApplication(),
      );
}
