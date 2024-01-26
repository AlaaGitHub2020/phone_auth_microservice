import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_microservice/injection.dart';

class PhoneAuthMicroserviceAppWidget extends StatelessWidget {
  ///Constructor
  const PhoneAuthMicroserviceAppWidget({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<HomeUiLogicBloc>(
            create: (_) => getIt<HomeUiLogicBloc>(),
          ),
        ],
        child: const PhoneAuthMicroserviceApplication(),
      );
}
