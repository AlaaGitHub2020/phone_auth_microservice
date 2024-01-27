import 'package:flutter/material.dart';
import 'package:phone_auth_microservice/domain/core/utilities/themes/theme_data_extension.dart';

mixin HelperMixin {
  void showErrorMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: Theme.of(context).color.mainBackground),
      ),
      backgroundColor: Theme.of(context).color.errorColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  ///build BoxDecoration
  BoxDecoration buildBoxDecoration(BuildContext context) => BoxDecoration(
      color: Theme.of(context).color.secondBackground,
      borderRadius: const BorderRadius.all(Radius.circular(13)));
}
