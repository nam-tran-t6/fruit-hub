import 'dart:convert';

import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/services/fruit_item_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import '../mock_data/fruit_item_mock.dart';

void main() {
  group('fetch fruit item details by id', () {
    test('Should return a FruitItem if the http call completes successfully', () async {
      final fetchFruitItem = FruitItemApiService();
      fetchFruitItem.httpClient =
          MockClient((_) async => http.Response(jsonEncode(mockFruitItem), 200));
      var response = await fetchFruitItem.fetchFruitItem('JEWPz');
      expect(response, isA<FruitItem>());
    });

    test('Should throw an exception if the http call completes with an error', () async {
      final fetchFruitItem = FruitItemApiService();
      fetchFruitItem.httpClient = MockClient(
          (request) async => http.Response('No matching items are found!', 404));
      expect(fetchFruitItem.fetchFruitItem('JEWPzz'), throwsException);
    });
  });
}
