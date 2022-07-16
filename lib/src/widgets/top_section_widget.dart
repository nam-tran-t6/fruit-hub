import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_basket/my_basket_cubit.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/helpers/extension/string_extension.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_colors.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_text_styles.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/app_images_path.dart';
import 'package:flutter_fruit_hub/src/screens/order_list_screen.dart';

class TopSectionWidget extends StatelessWidget {
  final String name;
  final String welcomeText;
  final GlobalKey<ScaffoldState> scaffoldKey;

  TopSectionWidget(
      {required this.name, required this.welcomeText, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24, right: 24, top: 16),
      color: AppColors.accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getAppBarWidget(context),
          SizedBox(
            height: 11,
          ),
          Container(
            width: 257,
            child: RichText(
              text: TextSpan(
                text: Strings.hello + name.capitalizeFirstLetter() + ', ',
                style: AppTextStyles.kNormalPortGore20
                    .copyWith(fontFamily: Strings.app_font_name),
                children: <TextSpan>[
                  TextSpan(
                    text: welcomeText,
                    style: AppTextStyles.kBoldPortGore20w600,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          SearchWidget()
        ],
      ),
    );
  }

  Widget getAppBarWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          child: Image.asset(AppImagePath.home_expand),
          onTap: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
        Column(
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<MyBasketCubit>(context).myBasketClicked();
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Image.asset(
                        AppImagePath.home_basket,
                      ),
                      Positioned(
                        child: BlocConsumer<MyBasketCubit, MyBasketState>(
                          listener: (context, state) {
                            if (state is MyBasketIsClicked) {
                              Navigator.pushNamed(context, OrderListScreen.TAG);
                            }
                          },
                          builder: (context, state) {
                            if (state is MyBasketInitial ||
                                state is MyBasketItemQuantity ||
                                state is MyBasketIsClicked ||
                                state is MyBasketLoadFromDb) {
                              return Container(
                                padding: EdgeInsets.all(6),
                                decoration: state.getTotalItem.toString() == '0'
                                    ? BoxDecoration()
                                    : BoxDecoration(
                                        color: Colors.red, shape: BoxShape.circle),
                                child: Text(
                                  state.getTotalItem.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                        right: -5,
                        top: -10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(Strings.my_basket, style: AppTextStyles.kNormalPortGore10),
          ],
        )
      ],
    );
  }

  Widget SearchWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: TextFormField(
            cursorColor: Colors.black,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFF3F4F9),
              hintText: Strings.search_for_fruit_salad_combos,
              hintStyle: AppTextStyles.kNormalManatee14,
              prefixIcon: Image.asset('assets/images/home_search.png'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 17,
        ),
        Image.asset(
          'assets/images/home_history.png',
        ),
      ],
    );
  }
}
