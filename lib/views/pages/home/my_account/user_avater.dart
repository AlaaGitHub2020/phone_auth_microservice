import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phone_auth_microservice/app_logic/home_ui_logic/home_ui_logic_bloc.dart';
import 'package:phone_auth_microservice/domain/core/utilities/constants.dart';
import 'package:phone_auth_microservice/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:phone_auth_microservice/domain/core/utilities/themes/theme_data_extension.dart';

///User Avatar
class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<HomeUiLogicBloc, HomeUiLogicState>(
        builder: (_, HomeUiLogicState homeUiLogicState) {
          getLogger().i('photoUrl:${homeUiLogicState.userModel.photoUrl}');
          return (homeUiLogicState.userModel.photoUrl != null &&
                  homeUiLogicState.userModel.photoUrl!.isNotEmpty)
              ? CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 45,
                  backgroundImage:
                      FileImage(File(homeUiLogicState.userModel.photoUrl!)),
                )
              : CircleAvatar(
                  radius: 45,
                  backgroundColor: Theme.of(context).color.avatarColor,
                  child: SvgPicture.asset(ViewsConstants.icMyAccountActive,
                      width: 30),
                );
        },
      );
}
