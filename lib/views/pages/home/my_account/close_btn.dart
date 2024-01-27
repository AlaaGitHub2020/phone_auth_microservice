import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_microservice/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:phone_auth_microservice/generated/l10n.dart';
import 'package:phone_auth_microservice/views/widgets/helper_mixin.dart';

class CloseBtn extends StatelessWidget with HelperMixin {
  const CloseBtn({super.key});

  @override
  Widget build(BuildContext context) => Container(
        decoration: buildBoxDecoration(context),
        width: MediaQuery.sizeOf(context).width * 0.85,
        height: 60,
        child: TextButton(
          onPressed: () {
            getLogger().i('close');
            context.router.pop();
          },
          child: Text(
            S.current.close,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
}
