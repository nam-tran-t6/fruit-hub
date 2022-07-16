import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppButtonStyles {
  static final ButtonStyle kWhiteBorder10 = ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    backgroundColor: MaterialStateProperty.all(AppColors.white),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
