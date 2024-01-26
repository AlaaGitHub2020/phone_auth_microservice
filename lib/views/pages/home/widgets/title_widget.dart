import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_microservice/app_logic/home_ui_logic/home_ui_logic_bloc.dart';
import 'package:phone_auth_microservice/domain/core/utilities/themes/theme_data_extension.dart';
import 'package:phone_auth_microservice/generated/l10n.dart';

///Title Widget
class TitleWidget extends StatelessWidget {
  ///Constructor
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<HomeUiLogicBloc, HomeUiLogicState>(
        builder: (BuildContext context, HomeUiLogicState homeUiLogicState) {
          return homeUiLogicState.maybeMap(
            orElse: () => buildTitle(context, '', ''),
            editFamily: (_) => buildTitle(context, S.current.account, S.current.yourFamily),
            editName: (_) => buildTitle(context, S.current.account, S.current.yourName),
            myProjects: (_) => Container(),
            myAccount: (_) =>
                buildTitle(context, S.current.myAccount, S.current.account),
          );
        },
      );

  Row buildTitle(BuildContext context, String text, String titleText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context)
                      .color
                      .bottomNavigationBarItemActiveColor,
                  fontSize: 16,
                )),
        const SizedBox(width: 20),
        Text(titleText,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).color.titleTextColor,
                )),
        const Spacer(),
      ],
    );
  }
}
