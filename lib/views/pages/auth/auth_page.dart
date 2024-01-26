import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phone_auth_microservice/app_logic/auth_ui_logic/auth_ui_logic_bloc.dart';
import 'package:phone_auth_microservice/domain/core/utilities/constants.dart';
import 'package:phone_auth_microservice/generated/l10n.dart';
import 'package:phone_auth_microservice/views/pages/auth/widgets/auth_page_body.dart';
import 'package:phone_auth_microservice/views/routes/router.gr.dart';
import 'package:phone_auth_microservice/views/widgets/helper_mixin.dart';

///Auth Page
class AuthPage extends StatelessWidget with HelperMixin {
  ///Constructor
  const AuthPage({super.key});

  ///AuthUiLogicBloc
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthUiLogicBloc, AuthUiLogicState>(
        listener: (_, AuthUiLogicState authUiLogicState) {
          authUiLogicState.maybeMap(
            orElse: () => null,
            authorizedUser: (_) {
              context.router.push(const HomeRoute());
            },
            errorState: (ErrorState errorState) {
              return errorState.failure.maybeMap(
                orElse: () {},
                fetchCurrentUserFailure: (_) => showErrorMessage(
                    context, S.current.fetchCurrentUserFailure),
                firebaseServerFailure: (_) =>
                    showErrorMessage(context, S.current.firebaseServerFailure),
                invalidPhoneNumberFailure: (_) => showErrorMessage(
                    context, S.current.invalidPhoneNumberFailure),
                tooManyRequestsFailure: (_) =>
                    showErrorMessage(context, S.current.tooManyRequestsFailure),
                verifyPhoneNumberFailure: (_) => showErrorMessage(
                    context, S.current.verifyPhoneNumberFailure),
              );
            },
          );
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: buildAppBar(context),
            body: const AuthPageBody(),
          );
        },
      ),
    );
  }

  ///build App Bar
  AppBar buildAppBar(BuildContext context) => AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: buildBackBtn(),
      );

  BlocBuilder<AuthUiLogicBloc, AuthUiLogicState> buildBackBtn() =>
      BlocBuilder<AuthUiLogicBloc, AuthUiLogicState>(
        builder: (BuildContext context, AuthUiLogicState authUiLogicState) {
          return authUiLogicState.maybeWhen(
            orElse: () => IconButton(onPressed: () => false, icon: buildIcon()),
            secondStep: (_, __, ___) => IconButton(
                onPressed: () => context
                    .read<AuthUiLogicBloc>()
                    .add(const AuthUiLogicEvent.stepChanged(1)),
                icon: buildIcon()),
          );
        },
      );

  SvgPicture buildIcon() => SvgPicture.asset(ViewsConstants.icBack);
}
