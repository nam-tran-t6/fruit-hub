import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/authentication/authentication_cubit.dart';
import 'package:flutter_fruit_hub/src/constants/app_shared_preferences_key.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_colors.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_text_styles.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/app_ratio.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/shared_preferences_utils.dart';
import 'package:flutter_fruit_hub/src/services/remote_config_service.dart';
import 'package:flutter_fruit_hub/src/widgets/app_button.dart';
import 'package:flutter_fruit_hub/src/widgets/app_loading_widget.dart';
import 'package:flutter_fruit_hub/src/widgets/intro_image.dart';
import 'package:flutter_fruit_hub/src/widgets/textfield_container.dart';

import 'home_screen.dart';

class AuthenticationScreen extends StatelessWidget {
  static const String TAG = 'authentication_screen';

  @override
  Widget build(BuildContext context) {
    var authCubit = BlocProvider.of<AuthenticationCubit>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.58,
              color: AppColors.texas_rose,
              child: Center(
                child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
                  builder: (context, state) {
                    return IntroImage(
                      imageUrl: AppRemoteConfigService().authFruitBasketImageUrl,
                      shadowUrl: AppRemoteConfigService().welcomeFruitShadowImageUrl,
                      dropUrl: AppRemoteConfigService().authFruitDropImageUrl,
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 56,
                  ),
                  Text(
                    Strings.what_your_first_name,
                    style: AppTextStyles.kNormalPortGore20,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldContainer(
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          left: 24,
                          top: 13,
                          bottom: 14,
                        ),
                        hintText: Strings.name_tony,
                        hintStyle: AppTextStyles.kNormalSilver20,
                        border: InputBorder.none,
                        isDense: false,
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: (data) => authCubit.setInputName(data),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
                      listener: (context, state) {
                        if (state is AuthenticationLoading) {
                          AppOverlayLoadingWidget().show(context);
                        } else {
                          AppOverlayLoadingWidget().pop();
                        }
                        if (state is AuthenticationSuccess) {
                          Navigator.pushNamed(
                            context,
                            HomeScreen.TAG,
                            arguments: state.username,
                          );
                          SharedPreferencesUtils().setString(
                              AppSharedPreferencesKey.USERNAME, state.username);
                          SharedPreferencesUtils()
                              .setBool(AppSharedPreferencesKey.LOGIN_SUCCESS, true);
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthenticationError) {
                          return Text(
                            state.getErrorMessage,
                            style: AppTextStyles.kNormalCinnabar14,
                          );
                        } else if (state is AuthenticationErrorInput) {
                          return Text(
                            state.getErrorMessage,
                            style: AppTextStyles.kNormalCinnabar14,
                          );
                        }
                        return Text('');
                      },
                    ),
                  ),
                  SizedBox(
                    height: 42,
                  ),
                  AppButton(
                    isPrimary: true,
                    width: MediaQuery.of(context).size.width,
                    height: 56,
                    buttonText: Strings.start_ordering,
                    onPressed: () {
                      authCubit.sendReqLogin();
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
