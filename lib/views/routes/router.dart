import 'package:auto_route/auto_route.dart';
import 'package:phone_auth_microservice/views/routes/router.gr.dart';

///App Router
@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();
  @override
  final List<AutoRoute> routes = <AutoRoute>[
    AutoRoute(page: AuthRoute.page, initial: true),
    AutoRoute(page: HomeRoute.page),
  ];
}
