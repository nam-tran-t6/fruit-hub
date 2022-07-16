import 'package:flutter_fruit_hub/src/models/collection_fruit_model.dart';

class CollectionMenuState {
  List<CollectionFruitMenu> listMenu;

  CollectionMenuState(this.listMenu);

  // List<CollectionFruitMenu> get listMenu => _listMenu;

  CollectionFruitMenu? menuSelect;

  String errorMessage = '';
}
