import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phone_auth_microservice/domain/core/utilities/constants.dart';
import 'package:phone_auth_microservice/domain/core/utilities/themes/theme_data_extension.dart';

///Account Avatar
class AccountAvatar extends StatelessWidget {
  ///Constructor
  const AccountAvatar({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 112,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: Theme.of(context).color.avatarColor,
              child:
                  SvgPicture.asset(ViewsConstants.icMyAccountActive, width: 30),
            ),
            Positioned(
              bottom: -8,
              right: 0,
              child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(ViewsConstants.icEdit)),
            ),
          ],
        ),
      );
}
