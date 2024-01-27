import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_microservice/app_logic/home_ui_logic/home_ui_logic_bloc.dart';
import 'package:phone_auth_microservice/generated/l10n.dart';
import 'package:phone_auth_microservice/views/pages/home/my_account/account_configure_btn.dart';

///FirstNameText
class FirstNameText extends StatelessWidget {
  const FirstNameText({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<HomeUiLogicBloc, HomeUiLogicState>(
        builder: (_, HomeUiLogicState homeUiLogicState) {
          final String firstName =
              (homeUiLogicState.userModel.firstName != null &&
                      homeUiLogicState.userModel.firstName!.isNotEmpty)
                  ? homeUiLogicState.userModel.firstName!
                  : S.current.name;

          return AccountConfigureBtn(
              whatToConfigure: firstName,
              onTap: () {
                context
                    .read<HomeUiLogicBloc>()
                    .add(const HomeUiLogicEvent.editNamePressed());
              });
        },
      );
}
