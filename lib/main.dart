import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:logger/logger.dart';
import 'package:phone_auth_microservice/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:phone_auth_microservice/views/core/phone_auth_microservice_app_widget.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      FlutterNativeSplash.preserve(
        widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
      );
      await appConfiguration();
      runApp(const PhoneAuthMicroserviceAppWidget());
    },
    (Object error, StackTrace stack) {
      getLogger().e('‍⛔[CrashEvent] [DEBUG] $error\n$stack');
    },
  );
}

///app Configuration
Future<void> appConfiguration() async {
  try {
    getLogger().i('appConfiguration Started');
    prepareTheLogger();
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: <SystemUiOverlay>[
        SystemUiOverlay.top,
        SystemUiOverlay.bottom,
      ],
    );
    await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp],
    );
    FlutterNativeSplash.remove();
  } on Exception catch (e) {
    getLogger().e('Exception Error : $e');
  }
}

///prepare The Logger
void prepareTheLogger() {
  try {
    getLogger().i('prepareTheLogger Started');
    if (kReleaseMode) {
      Logger.level = Level.info;
    } else {
      Logger.level = Level.debug;
    }
  } on Exception catch (error) {
    getLogger().e('Exception Error: $error');
  }
}
