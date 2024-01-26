import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phone_auth_microservice/app_logic/home_ui_logic/home_ui_logic_bloc.dart';
import 'package:phone_auth_microservice/domain/core/utilities/constants.dart';
import 'package:phone_auth_microservice/domain/core/utilities/themes/theme_data_extension.dart';
import 'package:phone_auth_microservice/generated/l10n.dart';

///Custom Bottom Navigation Bar
class CustomBottomNavigationBar extends StatelessWidget {
  ///Constructor
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<HomeUiLogicBloc, HomeUiLogicState>(
        builder: (BuildContext context, HomeUiLogicState homeUiLogicState) =>
            BottomNavigationBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          selectedItemColor:
              Theme.of(context).color.bottomNavigationBarItemActiveColor,
          currentIndex:
              (homeUiLogicState == const HomeUiLogicState.myProjects()) ? 0 : 1,
          onTap: (index) {
            context
                .read<HomeUiLogicBloc>()
                .add(const HomeUiLogicEvent.toggleTap());
          },
          items: [buildMyProjects(context), buildMyAccount(context)],
        ),
      );

  ///build My Account item
  BottomNavigationBarItem buildMyAccount(BuildContext context) =>
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(ViewsConstants.icMyAccountActive),
        icon: SvgPicture.asset(ViewsConstants.icMyAccount),
        label: S.current.myAccount,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      );

  ///build My Projects item
  BottomNavigationBarItem buildMyProjects(BuildContext context) =>
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(ViewsConstants.icMyProjectActive),
        icon: SvgPicture.asset(ViewsConstants.icMyProject),
        label: S.current.myProjects,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      );
}
