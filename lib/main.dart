import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_fruit_hub/src/config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppConfig().initialize();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FirebaseAnalytics().setAnalyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(MyApp());
}