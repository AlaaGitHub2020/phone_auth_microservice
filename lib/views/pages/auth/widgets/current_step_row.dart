import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_microservice/app_logic/auth_ui_logic/auth_ui_logic_bloc.dart';
import 'package:phone_auth_microservice/views/widgets/step_number.dart';

///Current Step Row
class CurrentStepRow extends StatelessWidget {
  const CurrentStepRow({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildFirstStep(),
            buildSecondStep(),
            buildThirdStep(),
          ],
        ),
      );

  ///build First Step
  BlocBuilder<AuthUiLogicBloc, AuthUiLogicState> buildFirstStep() =>
      BlocBuilder<AuthUiLogicBloc, AuthUiLogicState>(
        builder: (_, AuthUiLogicState authUiLogicState) =>
            authUiLogicState.maybeWhen(
          orElse: () => const StepNumber(active: false, stepNumber: 1),
          firstStep: (_) => const StepNumber(active: true, stepNumber: 1),
        ),
      );

  ///build Second Step
  BlocBuilder<AuthUiLogicBloc, AuthUiLogicState> buildSecondStep() =>
      BlocBuilder<AuthUiLogicBloc, AuthUiLogicState>(
        builder: (_, AuthUiLogicState authUiLogicState) =>
            authUiLogicState.maybeWhen(
          orElse: () => const StepNumber(active: true, stepNumber: 2),
          firstStep: (_) => const StepNumber(active: false, stepNumber: 2),
          thirdStep: (_) => const StepNumber(active: false, stepNumber: 2),
        ),
      );

  ///build Third Step
  BlocBuilder<AuthUiLogicBloc, AuthUiLogicState> buildThirdStep() =>
      BlocBuilder<AuthUiLogicBloc, AuthUiLogicState>(
        builder: (_, AuthUiLogicState authUiLogicState) =>
            authUiLogicState.maybeWhen(
          orElse: () => const StepNumber(active: false, stepNumber: 3),
          thirdStep: (_) => const StepNumber(active: true, stepNumber: 3),
        ),
      );
}
