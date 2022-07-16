import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/authentication/authentication_cubit.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_basket/my_basket_cubit.dart';
import 'package:flutter_fruit_hub/src/blocs/home/home_cubit.dart';
import 'package:flutter_fruit_hub/src/blocs/splash/splash_cubit.dart';
import 'package:flutter_fruit_hub/src/screens/add_to_basket_screen.dart';
import 'package:flutter_fruit_hub/src/screens/authentication_screen.dart';
import 'package:flutter_fruit_hub/src/screens/home_screen.dart';
import 'package:flutter_fruit_hub/src/screens/order_completed_screen.dart';
import 'package:flutter_fruit_hub/src/screens/order_list_screen.dart';
import 'package:flutter_fruit_hub/src/screens/splash_screen.dart';
import 'package:flutter_fruit_hub/src/screens/track_order_screen.dart';
import 'package:flutter_fruit_hub/src/screens/welcome_screen.dart';

class FruitHubRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    var routes = <String, WidgetBuilder>{
      SplashScreen.TAG: (context) {
        return BlocProvider(
          create: (context) => SplashCubit(),
          child: Builder(
            builder: (context) {
              BlocProvider.of<SplashCubit>(context).showSplashScreen();
              return SplashScreen();
            },
          ),
        );
      },
      HomeScreen.TAG: (_) => BlocProvider(
            create: (_) => HomeCubit(),
            child: Builder(builder: (context) {
              BlocProvider.of<MyBasketCubit>(context).addItemAddedFromDBToBasket();
              return HomeScreen();
            }),
          ),
      AuthenticationScreen.TAG: (_) => BlocProvider(
            create: (_) => AuthenticationCubit(),
            child: AuthenticationScreen(),
          ),
      AddToBasketScreen.TAG: (_) => AddToBasketScreen(),
      WelcomeScreen.TAG: (context) => WelcomeScreen(context),
      OrderListScreen.TAG: (_) => OrderListScreen(),
      OrderCompletedScreen.TAG: (_) => OrderCompletedScreen(),
      TrackOrderScreen.TAG: (_) => TrackOrderScreen(),
    };
    return routes;
  }
}
