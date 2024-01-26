import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:phone_auth_microservice/domain/core/utilities/constants.dart';
import 'package:phone_auth_microservice/domain/core/utilities/themes/theme_data_extension.dart';
import 'package:phone_auth_microservice/generated/l10n.dart';
import 'package:phone_auth_microservice/views/routes/router.dart';

///Phone Auth Microservice App Widget
class PhoneAuthMicroserviceApplication extends StatelessWidget {
  ///Constructor
  const PhoneAuthMicroserviceApplication({super.key});

  ///_appRouter
  static final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        theme: ThemeData().getAppTheme,
        locale: Locale(Platform.localeName),
        title: ViewsConstants.appTitle,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        localeResolutionCallback:
            (Locale? platformLocale, Iterable<Locale> supportedLocales) {
          for (final Locale locale in supportedLocales) {
            if (locale.languageCode ==
                platformLocale!.languageCode.split('_').elementAtOrNull(0)) {
              return locale;
            }
          }
          return null;
        },
      );
}
