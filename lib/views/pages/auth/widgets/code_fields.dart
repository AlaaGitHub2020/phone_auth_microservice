import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_microservice/app_logic/auth_ui_logic/auth_ui_logic_bloc.dart';
import 'package:phone_auth_microservice/domain/core/utilities/themes/theme_data_extension.dart';
import 'package:pinput/pinput.dart';

///Code Fields
class CodeFields extends StatefulWidget {
  ///Constructor
  const CodeFields({super.key});

  @override
  State<CodeFields> createState() => _CodeFieldsState();
}

class _CodeFieldsState extends State<CodeFields> {
  final focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthUiLogicBloc, AuthUiLogicState>(
      builder: (_, AuthUiLogicState authUiLogicState) {
        return authUiLogicState.maybeWhen(
            orElse: Container.new,
            errorState: (_, __, TextEditingController controller) => Pinput(
                  androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                  length: 6,
                  pinAnimationType: PinAnimationType.slide,
                  controller: controller,
                  focusNode: focusNode,
                  defaultPinTheme: buildDefaultPinTheme(),
                  showCursor: true,
                  cursor: buildCursor(Theme.of(context).color.secondText),
                  preFilledWidget: buildPreFilledWidget(),
                  onCompleted: (String value) {
                    context
                        .read<AuthUiLogicBloc>()
                        .add(const AuthUiLogicEvent.smsCodeFilled());
                  },
                ),
            secondStep: (__, int _, TextEditingController controller) {
              return Pinput(
                androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                length: 6,
                pinAnimationType: PinAnimationType.slide,
                controller: controller,
                focusNode: focusNode,
                defaultPinTheme: buildDefaultPinTheme(),
                showCursor: true,
                cursor: buildCursor(Theme.of(context).color.secondText),
                preFilledWidget: buildPreFilledWidget(),
                onCompleted: (String value) {
                  context
                      .read<AuthUiLogicBloc>()
                      .add(const AuthUiLogicEvent.smsCodeFilled());
                },
              );
            });
      },
    );
  }

  PinTheme buildDefaultPinTheme() {
    return PinTheme(
      width: 39,
      height: 34,
      textStyle:
          Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 28),
    );
  }

  Column buildCursor(Color borderColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: borderColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }

  Column buildPreFilledWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: Theme.of(context).color.secondText,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}
