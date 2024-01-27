import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:phone_auth_microservice/injection.config.dart';

///getIt
final GetIt getIt = GetIt.instance;

///configure Injection
@injectableInit
GetIt configureInjection(String env) => getIt.init(environment: env);
