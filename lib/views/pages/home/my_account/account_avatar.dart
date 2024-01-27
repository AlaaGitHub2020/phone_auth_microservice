import 'package:flutter/material.dart';
import 'package:phone_auth_microservice/views/pages/home/my_account/edit_avatar_btn.dart';
import 'package:phone_auth_microservice/views/pages/home/my_account/user_avater.dart';

///Account Avatar
class AccountAvatar extends StatelessWidget {
  ///Constructor
  const AccountAvatar({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox(
        width: 112,
        child: Stack(
          alignment: Alignment.center,
          children: [
            UserAvatar(),
            Positioned(
              bottom: -8,
              right: 0,
              child: EditAvatarBtn(),
            ),
          ],
        ),
      );
}
