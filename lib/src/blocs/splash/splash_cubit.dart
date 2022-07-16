import 'package:bloc/bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/shared_preferences_utils.dart';
import 'package:flutter_fruit_hub/src/services/remote_config_service.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashScreenState> {
  SplashCubit() : super(SplashScreenInitial());

  void showSplashScreen() async {
    await Firebase.initializeApp();
    await AppRemoteConfigService().setup();
    WidgetsFlutterBinding.ensureInitialized();
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FirebaseAnalytics().setAnalyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    await Future.delayed(Duration(seconds: 3));
    await SharedPreferencesUtils().setup();
    emit(SplashScreenFinish());
  }
}
