import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_colors.dart';

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color fillColor;
  final Color borderColor;
  final Color iconColor;
  final bool isDisable;
  final VoidCallback onPressed;

  RoundIconButton(
      {required this.icon,
      required this.size,
      required this.fillColor,
      required this.borderColor,
      this.isDisable = false,
      this.iconColor = AppColors.black,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(
                color: isDisable ? borderColor.withOpacity(0.3) : borderColor, width: 1),
            color: isDisable ? fillColor.withOpacity(0.5) : fillColor,
            shape: BoxShape.circle,
          ),
          child: InkWell(
            splashColor:
                isDisable ? null : AppColors.silver.withOpacity(0.7), // Splash color
            borderRadius: BorderRadius.circular(50),
            onTap: isDisable ? null : onPressed,
            child: SizedBox(
                width: size,
                height: size,
                child: Icon(
                  icon,
                  color: isDisable ? iconColor.withOpacity(0.3) : iconColor,
                )),
          ),
        ),
      ),
    );
  }
}
