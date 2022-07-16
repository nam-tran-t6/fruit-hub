import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_fruit_hub/src/blocs/welcome/welcome_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/welcome/welcome_event.dart';
import 'package:flutter_fruit_hub/src/blocs/welcome/welcome_state.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_colors.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_text_styles.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/app_ratio.dart';
import 'package:flutter_fruit_hub/src/screens/authentication_screen.dart';
import 'package:flutter_fruit_hub/src/services/remote_config_service.dart';
import 'package:flutter_fruit_hub/src/widgets/app_button.dart';
import 'package:flutter_fruit_hub/src/widgets/intro_image.dart';

class WelcomeScreen extends StatelessWidget {
  static const String TAG = 'welcome_screen';
  final bloc = WelcomeBloc();

  WelcomeScreen(context) {
    bloc.getEventStream().listen((event) {
      if (event is PressContinueButtonEvent) {
        Navigator.pushNamed(context, AuthenticationScreen.TAG);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              color: AppColors.texas_rose,
              child: Center(
                child: IntroImage(
                  imageUrl: AppRemoteConfigService().welcomeFruitImageUrl,
                  shadowUrl: AppRemoteConfigService().welcomeFruitShadowImageUrl,
                  dropUrl: AppRemoteConfigService().welcomeFruitDropImageUrl,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 56,
                  ),
                  Text(
                    AppRemoteConfigService().welcomeFreshestCombo,
                    style: AppTextStyles.kBoldPortGore20,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    AppRemoteConfigService().welcomeBestCombo,
                    style: AppTextStyles.kNormalSmoky16,
                  ),
                  SizedBox(
                    height: 58,
                  ),
                  StreamBuilder<WelcomeState>(
                    builder: (context, snapshot) {
                      return AppButton(
                        isPrimary: true,
                        height: 56,
                        buttonText: AppRemoteConfigService().welcomeMessageButton,
                        onPressed: () {
                          bloc.addEvent(
                            PressContinueButtonEvent(),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
