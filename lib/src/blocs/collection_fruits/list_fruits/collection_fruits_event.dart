import 'package:flutter_fruit_hub/src/models/collection_fruit_model.dart';
import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';

abstract class CollectionFruitEvent {}

class LoadListFruitEvent extends CollectionFruitEvent {
  final List<FruitItem> listFruit;

  LoadListFruitEvent(this.listFruit);
}

class FetchListFruitByMenuEvent extends CollectionFruitEvent {
  final CollectionFruitMenu menu;

  FetchListFruitByMenuEvent(this.menu);
}

class ShowErrorMessageEvent extends CollectionFruitEvent {
  final String message;

  ShowErrorMessageEvent(this.message);
}
