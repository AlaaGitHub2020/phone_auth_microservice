import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:phone_auth_microservice/app_logic/auth_ui_logic/auth_ui_logic_bloc.dart';
import 'package:phone_auth_microservice/domain/core/utilities/constants.dart';
import 'package:phone_auth_microservice/domain/models/auth/user_model.dart';
import 'package:phone_auth_microservice/generated/l10n.dart';
import 'package:phone_auth_microservice/views/pages/auth/widgets/code_fields.dart';
import 'package:phone_auth_microservice/views/widgets/custom_input_field/input_field.dart';

///Phone Number Field
class PhoneNumberField extends StatefulWidget {
  ///Constructor
  const PhoneNumberField({super.key});

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  var maskFormatter = MaskTextInputFormatter(mask: ViewsConstants.cPhoneMask);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthUiLogicBloc, AuthUiLogicState>(
        builder: (_, AuthUiLogicState authUiLogicState) {
          return authUiLogicState.maybeWhen(
            orElse: () => const CodeFields(),
            firstStep: (UserModel userModel) => InputField(
              onChange: (String value) {
                final UserModel newUserModel =
                    userModel.copyWith(phoneNumber: value);
                context
                    .read<AuthUiLogicBloc>()
                    .add(AuthUiLogicEvent.userModelChanged(newUserModel));
              },
              hint: S.current.phoneNumber,
              keyboardType: TextInputType.phone,
              maxLength: 18,
              initialValue: userModel.phoneNumber.isNotEmpty
                  ? userModel.phoneNumber
                  : '+7(',
              inputFormatters: [maskFormatter],
            ),
            secondStep: (_, __, ___) => const CodeFields(),
          );
        },
      );
}
