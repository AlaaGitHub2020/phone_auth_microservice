import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

///Home Route
@RoutePage()
class HomeRoute extends StatelessWidget {
  ///Constructor
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) => const Placeholder(
        child: Text('HomeRoute'),
      );
}
