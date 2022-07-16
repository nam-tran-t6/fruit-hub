import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_colors.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/app_images_path.dart';

class AppBottomSheetCloseButton extends StatelessWidget {
  final double width;
  final double height;
  final onPressed;

  AppBottomSheetCloseButton({
    required this.width,
    required this.height,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.accent,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Image.asset(AppImagePath.close_bottom_sheet_icon),
        ),
      ),
    );
  }
}
