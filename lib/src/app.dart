import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/config/routes.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/size_config.dart';
import 'package:flutter_fruit_hub/src/screens/splash_screen.dart';

import 'blocs/fruit_basket/my_basket_cubit.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ],
    );
    return BlocProvider(
      create: (context) => MyBasketCubit(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              // _initScreenRatio(context);
              return MaterialApp(
                title: Strings.app_name,
                theme: ThemeData(fontFamily: Strings.app_font_name),
                initialRoute: SplashScreen.TAG,
                routes: FruitHubRoutes.getRoutes(),
                home: SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
