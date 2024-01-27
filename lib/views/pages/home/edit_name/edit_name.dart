import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_microservice/app_logic/home_ui_logic/home_ui_logic_bloc.dart';
import 'package:phone_auth_microservice/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:phone_auth_microservice/domain/core/utilities/themes/theme_data_extension.dart';
import 'package:phone_auth_microservice/domain/models/auth/user_model.dart';
import 'package:phone_auth_microservice/generated/l10n.dart';
import 'package:phone_auth_microservice/views/widgets/custom_input_field/input_field.dart';

///Edit Name
class EditName extends StatelessWidget {
  ///Constructor
  const EditName({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(15),
        child: BlocBuilder<HomeUiLogicBloc, HomeUiLogicState>(
          builder: (_, HomeUiLogicState homeUiLogicState) {
            return InputField(
              onChange: (String value) {
                UserModel userModel =
                    homeUiLogicState.userModel.copyWith(firstName: value);
                getLogger().i('userModel:$userModel');
                context
                    .read<HomeUiLogicBloc>()
                    .add(HomeUiLogicEvent.userModelChanged(userModel));
              },
              keyboardType: TextInputType.text,
              maxLength: 30,
              initialValue: (homeUiLogicState.userModel.firstName != null &&
                      homeUiLogicState.userModel.firstName!.isNotEmpty)
                  ? homeUiLogicState.userModel.firstName
                  : '',
              hintTextForEdit: S.current.yourName,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Theme.of(context).color.disableButton,
                ),
              ),
              // inputFormatters: [maskFormatter],
            );
          },
        ),
      );
}
