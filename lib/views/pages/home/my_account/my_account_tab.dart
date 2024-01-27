import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_microservice/app_logic/home_ui_logic/home_ui_logic_bloc.dart';
import 'package:phone_auth_microservice/domain/core/utilities/themes/theme_data_extension.dart';
import 'package:phone_auth_microservice/views/pages/home/edit_family/edit_family.dart';
import 'package:phone_auth_microservice/views/pages/home/edit_name/edit_name.dart';
import 'package:phone_auth_microservice/views/pages/home/my_account/account_avatar.dart';
import 'package:phone_auth_microservice/views/pages/home/my_account/family_name_text.dart';
import 'package:phone_auth_microservice/views/pages/home/my_account/first_name_text.dart';

///My Account Tab
class MyAccountTab extends StatelessWidget {
  ///Constructor
  const MyAccountTab({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocBuilder<HomeUiLogicBloc, HomeUiLogicState>(
          builder: (_, HomeUiLogicState homeUiLogicState) {
            return homeUiLogicState.maybeMap(
              orElse: Container.new,
              editName: (_) => buildEditNameTab(),
              editFamily: (_) => buildEditFamilyTab(),
              myAccount: (_) => buildMyAccountTab(context),
            );
          },
        ),
      );

  ///build Edit Family Tab
  Column buildEditFamilyTab() => const Column(
        children: [SizedBox(height: 24), EditFamily()],
      );

  ///build Edit Name Tab
  Column buildEditNameTab() => const Column(
        children: [SizedBox(height: 24), EditName()],
      );

  ///build My Account Tab
  Column buildMyAccountTab(BuildContext context) => Column(
        children: [
          const Divider(),
          const SizedBox(height: 24),
          const AccountAvatar(),
          const SizedBox(height: 15),
          buildEmailText(),
          const SizedBox(height: 24),
          Container(
            color: Theme.of(context).color.secondBackground,
            child: const Column(
              children: [FirstNameText(), FamilyNameText()],
            ),
          ),
        ],
      );

  BlocBuilder<HomeUiLogicBloc, HomeUiLogicState> buildEmailText() =>
      BlocBuilder<HomeUiLogicBloc, HomeUiLogicState>(
        builder: (BuildContext context, HomeUiLogicState homeUiLogicState) {
          return Text((homeUiLogicState.userModel.emailAddress != null &&
                  homeUiLogicState.userModel.emailAddress!.isNotEmpty)
              ? homeUiLogicState.userModel.emailAddress!
              : 'apollo@gmail.com');
        },
      );
}
