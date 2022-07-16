import 'package:flutter_fruit_hub/src/services/collection_menu_api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late CollectionMenuApiService service;
  group('Collection Menu Api Service', () {
    setUpAll(() {
      registerFallbackValue<Uri>(FakeUri());
    });

    setUp(() {
      var mockClient = MockClient();
      service = CollectionMenuApiService();
      service.httpClient = mockClient;
    });

    test('Should init internal CollectionMenuRepositoryImpl when not injected', () {
      expect(CollectionMenuApiService(), isNotNull);
    });

    test('Should return valid menu when get status code 200', () async {
      String json = r'''{
         "options": ["Recommended", "Hottest", "Popular", "New combo", "Top"]
      }''';
      when(() => service.httpClient.get(any()))
          .thenAnswer((_) async => http.Response(json, 200));
      var result = await service.fetchListMenu();
      expect(result.length, 5);
    });

    test('Should throw FetchDataException when get status code 500', () {
      when(() => service.httpClient.get(any()))
          .thenAnswer((_) async => http.Response('', 500));
      expect(() => service.fetchListMenu(), throwsException);
    });

    test('Should correct List Menu endpoint', () {
      expect(service.getEndpoint(), CollectionMenuApiService.END_POINT);
    });

    test('Should empty param in List Menu endpoint', () {
      expect(service.getParams(), null);
    });
  });
}
