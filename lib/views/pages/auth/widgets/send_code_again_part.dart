import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_microservice/app_logic/auth_ui_logic/auth_ui_logic_bloc.dart';
import 'package:phone_auth_microservice/domain/core/utilities/themes/theme_data_extension.dart';
import 'package:phone_auth_microservice/generated/l10n.dart';

///Send Code Again Part
class SendCodeAgainPart extends StatelessWidget {
  ///Constructor
  const SendCodeAgainPart({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthUiLogicBloc, AuthUiLogicState>(
        builder: (_, AuthUiLogicState authUiLogicState) {
          return authUiLogicState.maybeWhen(
            orElse: () => Column(
              children: [
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () {
                    context
                        .read<AuthUiLogicBloc>()
                        .add(const AuthUiLogicEvent.sendCodePressed());
                  },
                  child: Text(
                    S.current.sendTheCodeAgain,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Theme.of(context).color.mainButton),
                  ),
                ),
              ],
            ),
            firstStep: (_) => const SizedBox(height: 120),
            secondStep: (_, int time, __) {
              return Column(
                children: [
                  const SizedBox(height: 40),
                  time > 0
                      ? Text(S.current.secondsUntil(time),
                          style: Theme.of(context).textTheme.displayMedium)
                      : TextButton(
                          onPressed: () {
                            context
                                .read<AuthUiLogicBloc>()
                                .add(const AuthUiLogicEvent.sendCodePressed());
                          },
                          child: Text(
                            S.current.sendTheCodeAgain,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    color: Theme.of(context).color.mainButton),
                          ),
                        ),
                ],
              );
            },
            thirdStep: (_) => Container(),
          );
        },
      );
}
