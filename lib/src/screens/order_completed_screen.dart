import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_basket/my_basket_cubit.dart';
import 'package:flutter_fruit_hub/src/blocs/order_completed/order_completed_bloc.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_colors.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_text_styles.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/app_images_path.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/app_ratio.dart';

class OrderCompletedScreen extends StatelessWidget {
  static const String TAG = 'order_completed_screen';

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MyBasketCubit>(context).clearBasket();
    var _bloc = OrderCompletedCubit();
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 164,
                height: 164,
                child: Image.asset(AppImagePath.congratulation_group_icon)),
            SizedBox(
              height: 56,
            ),
            Text(
              Strings.congratulations,
              style: AppTextStyles.kBoldPortGore32.copyWith(
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              Strings.your_order_taken_attended_to,
              style: AppTextStyles.kNormalPortGore20.copyWith(
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 56,
            ),
            ElevatedButton(
              onPressed: () {
                _bloc.onPressedTrackOrderButton(context);
              },
              child: Padding(
                padding: EdgeInsets.only(left: 32, right: 32, top: 16, bottom: 16),
                child: Text(
                  Strings.track_order,
                  style: AppTextStyles.kNormalWhite16,
                ),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.texas_rose),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
            ),
            SizedBox(
              height: 60,
            ),
            ElevatedButton(
              onPressed: () {
                _bloc.onPressedContinueShoppingButton(context);
              },
              child: Padding(
                  padding: EdgeInsets.only(left: 32, right: 32, top: 16, bottom: 16),
                  child: Text(
                    Strings.continue_shopping,
                    style: AppTextStyles.kNormalTexasRose16,
                  )),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(AppColors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    side: BorderSide(color: AppColors.texas_rose),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
