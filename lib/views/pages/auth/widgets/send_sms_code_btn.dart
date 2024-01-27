import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_microservice/app_logic/auth_ui_logic/auth_ui_logic_bloc.dart';
import 'package:phone_auth_microservice/domain/models/auth/user_model.dart';
import 'package:phone_auth_microservice/generated/l10n.dart';
import 'package:phone_auth_microservice/views/widgets/loading.dart';

///Send SMS Code Button
class SendSmsCodeBtn extends StatelessWidget {
  ///Constructor
  const SendSmsCodeBtn({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthUiLogicBloc, AuthUiLogicState>(
        builder: (_, AuthUiLogicState authUiLogicState) {
          return authUiLogicState.maybeWhen(
            orElse: Container.new,
            firstStep: (UserModel userModel) => ElevatedButton(
              onPressed: (userModel.phoneNumber.isEmpty ||
                      !userModel.phoneNumber.isValidPhone())
                  ? null
                  : () {
                      context
                          .read<AuthUiLogicBloc>()
                          .add(const AuthUiLogicEvent.sendCodePressed());
                    },
              child: Text(
                S.current.sendSmsCode,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontSize: 16),
              ),
            ),
            thirdStep: (_) => const Loading(),
          );
        },
      );
}
