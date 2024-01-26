import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_microservice/app_logic/home_ui_logic/home_ui_logic_bloc.dart';
import 'package:phone_auth_microservice/views/pages/home/my_account/my_account_tab.dart';

///Home Page
class HomePage extends StatelessWidget {
  ///Constructor
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<HomeUiLogicBloc, HomeUiLogicState>(
        builder: (_, HomeUiLogicState homeUiLogicState) =>
            homeUiLogicState.maybeMap(
          orElse: () => const MyAccountTab(),
          myProjects: (_) => Container(),
          myAccount: (_) => const MyAccountTab(),
        ),
      );
}
