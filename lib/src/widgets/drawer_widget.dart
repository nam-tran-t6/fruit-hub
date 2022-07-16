import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/constants/app_shared_preferences_key.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_colors.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_text_styles.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/app_images_path.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/app_ratio.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/shared_preferences_utils.dart';
import 'package:flutter_fruit_hub/src/screens/welcome_screen.dart';

class DrawerWidget extends StatelessWidget {
  final String username;

  DrawerWidget({required this.username});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppImagePath.fruit_drawer_background,
          fit: BoxFit.fitHeight,
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                AppColors.texas_rose_gradient_start.withOpacity(0.85),
                AppColors.texas_rose_gradient_end.withOpacity(0.85),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.75,
          padding: EdgeInsets.fromLTRB(24, 60, 24, 60),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          'https://avatarfiles.alphacoders.com/252/252153.jpg'),
                    ),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      border: new Border.all(
                        color: AppColors.white,
                        width: 2,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '$username',
                    style:
                        AppTextStyles.kNormalPortGore20.copyWith(color: AppColors.black),
                  )
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 30,
                      child: Row(
                        children: [
                          Image.asset(
                            AppImagePath.icon_home,
                            width: 20,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Home',
                            style: AppTextStyles.kNormalPortGore20
                                .copyWith(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Container(
                      height: 30,
                      child: Row(
                        children: [
                          Image.asset(
                            AppImagePath.icon_profile,
                            width: 20,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Profile',
                            style: AppTextStyles.kNormalPortGore20
                                .copyWith(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Container(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppImagePath.icon_dark_mode,
                                width: 20,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Dark mode',
                                style: AppTextStyles.kNormalPortGore20
                                    .copyWith(color: AppColors.white),
                              ),
                            ],
                          ),
                          Switch(
                            value: false,
                            inactiveThumbColor: AppColors.white,
                            inactiveTrackColor: AppColors.white.withOpacity(0.5),
                            activeTrackColor: AppColors.texas_rose,
                            activeColor: AppColors.white,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Container(
                      height: 30,
                      child: Row(
                        children: [
                          Image.asset(
                            AppImagePath.icon_help,
                            width: 20,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Help',
                            style: AppTextStyles.kNormalPortGore20
                                .copyWith(color: AppColors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showMyDialog(context);
                },
                child: Row(
                  children: [
                    Image.asset(
                      AppImagePath.icon_logout,
                      width: 20,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Logout',
                      style: AppTextStyles.kNormalPortGore20
                          .copyWith(color: AppColors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure want to log out?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                SharedPreferencesUtils()
                    .setBool(AppSharedPreferencesKey.LOGIN_SUCCESS, false);
                Navigator.pushNamedAndRemoveUntil(
                    context, WelcomeScreen.TAG, (r) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
