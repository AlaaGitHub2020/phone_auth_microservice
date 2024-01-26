import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phone_auth_microservice/domain/core/utilities/constants.dart';
import 'package:phone_auth_microservice/domain/core/utilities/themes/theme_data_extension.dart';
import 'package:phone_auth_microservice/generated/l10n.dart';

///Account Configure Btn
class AccountConfigureBtn extends StatelessWidget {
  ///Constructor
  const AccountConfigureBtn(
      {required this.whatToConfigure, this.onTap, super.key});

  final String whatToConfigure;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.only(left: 26, right: 26, top: 8, bottom: 8),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: buildBorder(context)),
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildText(context),
              Row(
                children: [
                  buildConfigureText(context),
                  const SizedBox(width: 8),
                  SvgPicture.asset(ViewsConstants.icNext)
                ],
              ),
            ],
          ),
        ),
      );

  ///build Configure Text
  Text buildConfigureText(BuildContext context) => Text(
        S.current.configure,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Theme.of(context).color.configureTextColor, fontSize: 16),
      );

  ///build Text
  Text buildText(BuildContext context) => Text(
        whatToConfigure,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).color.titleTextColor, fontSize: 16),
      );

  ///build Border
  Border buildBorder(BuildContext context) => Border(
        bottom: BorderSide(color: Theme.of(context).color.configureTextColor),
      );
}
