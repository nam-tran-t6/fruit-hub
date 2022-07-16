import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/splash/splash_cubit.dart';
import 'package:flutter_fruit_hub/src/constants/app_shared_preferences_key.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/app_ratio.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/shared_preferences_utils.dart';
import 'package:flutter_fruit_hub/src/screens/welcome_screen.dart';
import 'package:flutter_fruit_hub/src/services/remote_config_service.dart';

import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String TAG = 'splash_screen';

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashScreenState>(
      listener: (context, state) {
        if (state is SplashScreenFinish) {
          bool? checkLogin =
              SharedPreferencesUtils().getBool(AppSharedPreferencesKey.LOGIN_SUCCESS) ??
                  false;

          if (checkLogin) {
            String? username =
                SharedPreferencesUtils().getString(AppSharedPreferencesKey.USERNAME);
            Navigator.pushReplacementNamed(context, HomeScreen.TAG, arguments: username);
          } else {
            Navigator.pushReplacementNamed(context, WelcomeScreen.TAG);
          }
        }
      },
      child: Scaffold(
        body: Center(
          child: FractionallySizedBox(
              widthFactor: 0.75,
              heightFactor: 0.5,
              child: Image.network(AppRemoteConfigService().splashImage)),
        ),
      ),
    );
  }
}
