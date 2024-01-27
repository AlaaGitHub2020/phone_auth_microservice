import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_microservice/app_logic/auth_ui_logic/auth_ui_logic_bloc.dart';
import 'package:phone_auth_microservice/domain/core/utilities/themes/theme_data_extension.dart';
import 'package:phone_auth_microservice/generated/l10n.dart';

///Agreement Text
class AgreementText extends StatelessWidget {
  const AgreementText({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthUiLogicBloc, AuthUiLogicState>(
        builder: (_, AuthUiLogicState authUiLogicState) {
          return authUiLogicState.maybeWhen(
            orElse: Container.new,
            firstStep: (_) => SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.6,
              child: RichText(
                textAlign: TextAlign.center,
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: buildByClickingOnText(context),
              ),
            ),
          );
        },
      );

  ///By Clicking On Text
  TextSpan buildByClickingOnText(BuildContext context) => TextSpan(
        text: S.current.byClickingOn,
        style: Theme.of(context).textTheme.titleSmall,
        children: <TextSpan>[
          buildPersonalDataText(context),
        ],
      );

  ///build Personal Data Text
  TextSpan buildPersonalDataText(BuildContext context) => TextSpan(
        text: S.current.personalData,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: Theme.of(context).color.mainButton),
      );
}
