import 'package:flutter_fruit_hub/src/models/collection_fruit_model.dart';

abstract class CollectionMenuEvent {}

class SelectCollectionEvent extends CollectionMenuEvent {
  final CollectionFruitMenu menuSelected;

  SelectCollectionEvent(this.menuSelected);
}

class DisplayListMenuEvent extends CollectionMenuEvent {
  final List<CollectionFruitMenu> menus;

  DisplayListMenuEvent(this.menus);
}

class RequestFetchListMenuEvent extends CollectionMenuEvent {}

class StartRequestDataEvent extends CollectionMenuEvent {}

class CollectionMenuError extends CollectionMenuEvent {
  String message;

  CollectionMenuError(this.message);
}
