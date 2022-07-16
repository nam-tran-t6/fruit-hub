import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/helpers/extension/num_extension.dart';
import 'package:flutter_fruit_hub/src/helpers/extension/string_extension.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_text_styles.dart';
import 'package:flutter_fruit_hub/src/models/item_added_basket_model.dart';

class FruitListTile extends StatelessWidget {
  final ItemAddedBasketModel itemAddedBasketModel;

  const FruitListTile({Key? key, required this.itemAddedBasketModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ListTile(
            title: Text(
              itemAddedBasketModel.fruitItem.name!,
              style: AppTextStyles.kBoldBlack16,
            ),
            subtitle: Text(
              '${itemAddedBasketModel.quantity}packs',
              style: AppTextStyles.kNormalBlack14,
            ),
            trailing: Text(
                '${itemAddedBasketModel.fruitItem.currency} '
                '${(itemAddedBasketModel.quantity * itemAddedBasketModel.fruitItem.price!).toCurrencyFormat()}',
                style: AppTextStyles.kBoldBlack16),
            leading: Container(
              width: 65,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Color(itemAddedBasketModel.fruitItem.color!.toHexColor()),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Container(
                  width: 40,
                  height: 40,
                  child: Image.network(itemAddedBasketModel.fruitItem.imageUrl![0]),
                ),
              ),
            ),
          ),
        ),
        Divider(
          height: 16.0,
        ),
      ],
    );
  }
}
