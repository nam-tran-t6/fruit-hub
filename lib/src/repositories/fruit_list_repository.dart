import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/services/fruit_list_service.dart';

abstract class FruitListRepository {
  Future<FruitList> fetchListFruit(String collectionName);
}

class FruitListRepositoryImpl implements FruitListRepository {
  @override
  Future<FruitList> fetchListFruit(String collectionName) async {
    var fruits = await FruitListApiService().fetchFruitList(collectionName);
    return fruits;
  }
}
