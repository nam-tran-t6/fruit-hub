import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/constants/app_constants.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_colors.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_text_styles.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final VoidCallback actionBackPress;
  final double percentageHeight;

  const AppBarWidget(
      {Key? key,
      this.title = '',
      required this.actionBackPress,
      this.percentageHeight = DEFAULT_APP_BAR_PERCENTAGE_HEIGHT})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: 24, right: 24, top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(color: AppColors.texas_rose),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * percentageHeight,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Material(
              color: Colors.transparent,
              child: Ink(
                width: 80,
                height: 32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90), color: Colors.white),
                child: InkWell(
                  onTap: actionBackPress,
                  splashColor: AppColors.texas_rose.withOpacity(0.5),
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_back_ios_rounded,
                        color: AppColors.black,
                        size: 18,
                      ),
                      Flexible(
                        child: Text(
                          Strings.app_bar_back_button_title,
                          style: AppTextStyles.kNormalBlack16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: AppTextStyles.kBoldWhite24,
            ),
          )
        ],
      ),
    );
  }
}
