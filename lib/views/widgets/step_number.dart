import 'package:flutter/material.dart';
import 'package:phone_auth_microservice/domain/core/utilities/themes/theme_data_extension.dart';

///Step
class StepNumber extends StatelessWidget {
  ///Constructor
  const StepNumber({required this.stepNumber, required this.active, super.key});

  ///Step Number text
  final String stepNumber;

  ///Active
  final bool active;

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        elevation: 0,
        backgroundColor: active
            ? Theme.of(context).color.mainButton
            : Theme.of(context).color.disableButton,
        shape: const CircleBorder(),
        onPressed: null,
        child: Text(stepNumber, style: Theme.of(context).textTheme.bodySmall),
      );
}
