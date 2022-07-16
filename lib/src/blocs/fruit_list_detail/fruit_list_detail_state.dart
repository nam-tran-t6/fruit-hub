import 'package:flutter_fruit_hub/src/models/fruit_item_detail.dart';

abstract class FruitDetailState {}

class FruitDetailInitialState extends FruitDetailState {

}

class FruitDetailLoadedState extends FruitDetailState{
  FruitItemDetail fruitItemDetail;

  FruitDetailLoadedState(this.fruitItemDetail);
}

class FruitDetailAmountState extends FruitDetailState{
  final int quantityOrder;

  FruitDetailAmountState(this.quantityOrder);
}

class FruitDetailTotalPriceState extends FruitDetailState{
  final int totalPrice;

  FruitDetailTotalPriceState(this.totalPrice);
}


class ShouldBackToHomeScreen extends FruitDetailState{

  ShouldBackToHomeScreen();
}

class FruitItemCurrentFavoriteState extends FruitDetailState {
  final bool isFavorite;

  FruitItemCurrentFavoriteState({required this.isFavorite});
}