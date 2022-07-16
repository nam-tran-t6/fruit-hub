import 'dart:convert';
import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/services/base_service/base_api_service.dart';

class FruitItemApiService extends BaseApiService {
  late String id;

  Future<FruitItem> fetchFruitItem(String id) async {
    this.id = id;
    var response = await executeGetRequest();
    return FruitItem.fromJson(jsonDecode(response));
  }

  @override
  String getEndpoint() {
    return '/dev/fruit-hub/combo/$id';
  }

  @override
  Map<String, dynamic>? getParams() {
    return null;
  }
}
