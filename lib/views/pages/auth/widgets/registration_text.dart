import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_microservice/app_logic/auth_ui_logic/auth_ui_logic_bloc.dart';
import 'package:phone_auth_microservice/generated/l10n.dart';

///Registration Text
class RegistrationText extends StatelessWidget {
  ///Constructor
  const RegistrationText({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.6,
        child: Column(
          children: [
            buildRegistrationText(),
            const SizedBox(height: 24),
            buildEnterYourPhoneNumberText(),
          ],
        ),
      );

  ///build Enter Your Phone Number Text
  BlocBuilder<AuthUiLogicBloc, AuthUiLogicState>
      buildEnterYourPhoneNumberText() =>
          BlocBuilder<AuthUiLogicBloc, AuthUiLogicState>(
            builder: (BuildContext context, AuthUiLogicState authUiLogicState) {
              return authUiLogicState.maybeWhen(
                orElse: () => Text(
                  S.current
                      .enterTheCode(authUiLogicState.userModel.phoneNumber),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                firstStep: (_) => Text(
                  S.current.enterYourPhoneNumberToRegister,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                thirdStep: (_) => Container(),
              );
            },
          );

  ///build Registration Text
  BlocBuilder<AuthUiLogicBloc, AuthUiLogicState> buildRegistrationText() =>
      BlocBuilder<AuthUiLogicBloc, AuthUiLogicState>(
        builder: (BuildContext context, AuthUiLogicState authUiLogicState) {
          return authUiLogicState.maybeWhen(
            orElse: () => Text(
              S.current.confirmation,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            firstStep: (_) => Text(
              S.current.registration,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            thirdStep: (_) => Container(),
          );
        },
      );
}
