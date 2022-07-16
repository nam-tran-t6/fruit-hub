import 'package:flutter_fruit_hub/src/models/collection_fruit_model.dart';
import 'package:flutter_fruit_hub/src/services/collection_menu_api_service.dart';

abstract class CollectionMenuRepository {
  Future<List<CollectionFruitMenu>> fetchListMenu();
}

class CollectionMenuRepositoryImpl implements CollectionMenuRepository {
  CollectionMenuApiService _service = CollectionMenuApiService();

  //add Setter for writing UT
  set service(CollectionMenuApiService value) {
    _service = value;
  }

  @override
  Future<List<CollectionFruitMenu>> fetchListMenu() async {
    var fruits = await _service.fetchListMenu();
    return fruits;
  }
}
