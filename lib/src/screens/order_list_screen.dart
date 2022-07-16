import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/complete_detail/complete_detail_cubit.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_basket/my_basket_cubit.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/helpers/extension/num_extension.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_text_styles.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/app_ratio.dart';
import 'package:flutter_fruit_hub/src/widgets/app_bar_widget.dart';
import 'package:flutter_fruit_hub/src/widgets/app_button.dart';
import 'package:flutter_fruit_hub/src/widgets/complete_details_widget.dart';
import 'package:flutter_fruit_hub/src/widgets/fruit_list_tile.dart';

class OrderListScreen extends StatelessWidget {
  static const String TAG = 'order_list_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomBar(context),
      body: Column(
        children: [
          AppBarWidget(
              title: Strings.my_basket_title,
              actionBackPress: () => Navigator.pop(context)),
          buildListOrder(context),
        ],
      ),
    );
  }

  Widget buildListOrder(BuildContext context) {
    if (BlocProvider.of<MyBasketCubit>(context).itemList.isNotEmpty) {
      return Expanded(
        child: ListView.builder(
          itemBuilder: (context, int index) {
            return FruitListTile(
              itemAddedBasketModel:
                  BlocProvider.of<MyBasketCubit>(context).itemList[index],
            );
          },
          itemCount: BlocProvider.of<MyBasketCubit>(context).itemList.length,
        ),
      );
    }
    return Expanded(
      child: Center(
        child: Text(Strings.your_basket_empty),
      ),
    );
  }

  Widget buildBottomBar(BuildContext context) {
    var basket = BlocProvider.of<MyBasketCubit>(context);
    var currency = basket.getCurrencySymbol();
    num total = basket.calculateTotalPrice();
    return SafeArea(
      child: Container(
        height: 64,
        margin: EdgeInsets.only(bottom: 10, top: 10),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    Strings.total,
                    style: AppTextStyles.kBoldBlack16,
                  ),
                  Text(
                    currency + total.toCurrencyFormat(),
                    style: AppTextStyles.kBoldPortGore24,
                  ),
                ],
              ),
              Builder(
                builder: (context) {
                  return AppButton(
                    isPrimary: true,
                    width: 199,
                    height: 56,
                    buttonText: Strings.check_out,
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        isDismissible: false,
                        context: context,
                        builder: (context) => BlocProvider(
                          create: (context) => CompleteDetailCubit(),
                          child: CompleteDetailsWidget(),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
