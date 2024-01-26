import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phone_auth_microservice/app_logic/home_ui_logic/home_ui_logic_bloc.dart';
import 'package:phone_auth_microservice/domain/core/utilities/constants.dart';
import 'package:phone_auth_microservice/domain/core/utilities/themes/theme_data_extension.dart';
import 'package:phone_auth_microservice/views/pages/home/home_page.dart';
import 'package:phone_auth_microservice/views/pages/home/widgets/custom_bottom_navigation_bar.dart';
import 'package:phone_auth_microservice/views/pages/home/widgets/title_widget.dart';

///Home Route
@RoutePage()
class HomeRoute extends StatelessWidget {
  ///Constructor
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).color.secondBackground,
          appBar: buildAppBar(),
          bottomNavigationBar: const CustomBottomNavigationBar(),
          body: const HomePage(),
        ),
      );

  AppBar buildAppBar() => AppBar(
        leading: buildLeading(),
        titleSpacing: 0,
        title: const TitleWidget(),
      );

  BlocBuilder<HomeUiLogicBloc, HomeUiLogicState> buildLeading() =>
      BlocBuilder<HomeUiLogicBloc, HomeUiLogicState>(
        builder: (BuildContext context, HomeUiLogicState homeUiLogicState) {
          return homeUiLogicState.maybeMap(
            orElse: () => IconButton(
                onPressed: () {
                  context
                      .read<HomeUiLogicBloc>()
                      .add(const HomeUiLogicEvent.toggleTap(tabNumber: 1));
                },
                icon: SvgPicture.asset(ViewsConstants.icBackActive)),
            myProjects: (_) => Container(),
            myAccount: (_) => IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(ViewsConstants.icBackActive)),
          );
        },
      );
}
