import 'dart:collection';
import 'dart:convert';

import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/services/base_service/base_api_service.dart';

class FruitListApiService extends BaseApiService {
  late Map<String, dynamic> params;

  Future<FruitList> fetchFruitList(String collectionName) async {
    params = new HashMap();
    params['collection'] = collectionName;

    var dataStr = await executeGetRequest();
    Map<String, dynamic> dataJson = json.decode(dataStr);
    return FruitList.fromJson(dataJson);
  }

  @override
  String getEndpoint() {
    return '/dev/fruit-hub/';
  }

  @override
  Map<String, dynamic>? getParams() {
    return params;
  }
}
