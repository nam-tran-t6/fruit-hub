import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppBoxDecorStyles {
  static final BoxDecoration kShadowMineShaft = BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: AppColors.mine_shaft,
        offset: Offset(3, 3),
      ),
    ],
  );

  static final BoxDecoration kShadowMineShaft005 = BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: AppColors.mine_shaft.withOpacity(0.05),
        offset: Offset(3, 3),
      ),
    ],
  );

  static final BoxDecoration kShadowMineShaft005Radius16 = kShadowMineShaft005.copyWith(
    borderRadius: BorderRadius.all(
      Radius.circular(16),
    ),
  );
}
