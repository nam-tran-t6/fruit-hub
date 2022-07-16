import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_colors.dart';

class IntroContent extends StatelessWidget {
  final Widget child;

  IntroContent({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.accent,
      child: child,
    );
  }
}
