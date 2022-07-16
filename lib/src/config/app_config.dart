import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/services/logger_service.dart';

class AppConfig {
  static final AppConfig _singleton = AppConfig._internal();

  AppConfig._internal();

  static final AppConfig instance = AppConfig();

  factory AppConfig() {
    return _singleton;
  }

  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    configureLogger();
  }

  void configureLogger() {
    LoggerService(
      logOutputs: [
        ConsoleLogger(),
        FirebaseLogger(FirebaseCrashlytics.instance)
      ],
    );
  }
}
