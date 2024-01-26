import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_microservice/injection.dart';
import 'package:phone_auth_microservice/views/pages/auth/auth_page.dart';

///Auth Route
@RoutePage()
class AuthRoute extends StatelessWidget {
  ///Constructor
  const AuthRoute({super.key});

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: getIt.allReady(),
        builder: (BuildContext _, AsyncSnapshot<void> snapshot) {
          if (snapshot.hasData) {
            return const AuthPage();
          }
          return const Center(child: CircularProgressIndicator());
        },
      );
}
