import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_microservice/app_logic/home_ui_logic/home_ui_logic_bloc.dart';
import 'package:phone_auth_microservice/generated/l10n.dart';
import 'package:phone_auth_microservice/views/pages/home/my_account/account_configure_btn.dart';

class FamilyNameText extends StatelessWidget {
  const FamilyNameText({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<HomeUiLogicBloc, HomeUiLogicState>(
        builder: (_, HomeUiLogicState homeUiLogicState) {
          final String familyName =
              (homeUiLogicState.userModel.secondName != null &&
                      homeUiLogicState.userModel.secondName!.isNotEmpty)
                  ? homeUiLogicState.userModel.secondName!
                  : S.current.familyName;
          return AccountConfigureBtn(
              whatToConfigure: familyName,
              onTap: () {
                context
                    .read<HomeUiLogicBloc>()
                    .add(const HomeUiLogicEvent.editFamilyPressed());
              });
        },
      );
}
