import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_colors.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final bool isPrimary;
  final double width;
  final double height;
  final String buttonText;
  final onPressed;

  AppButton({
    required this.isPrimary,
    this.width = double.infinity,
    this.height = double.infinity,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isPrimary ? AppColors.texas_rose : AppColors.accent,
        border: isPrimary
            ? null
            : Border.all(
                color: AppColors.texas_rose,
                width: 1,
              ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        child: Text(
          buttonText,
          style: isPrimary ? AppTextStyles.kBoldAccent16 : AppTextStyles.kBoldTexasRose16,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
