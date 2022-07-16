import 'package:flutter/cupertino.dart';
import 'package:flutter_fruit_hub/src/models/item_added_basket_model.dart';

abstract class FruitItemEvent {}

class FruitItemFetchRequest extends FruitItemEvent {
  final String? id;
  FruitItemFetchRequest({required this.id});
}

class FruitItemEventAddToBasket extends FruitItemEvent {
  final BuildContext context;
  final ItemAddedBasketModel itemAddedBasketModel;
  FruitItemEventAddToBasket(this.context,this.itemAddedBasketModel);
}
