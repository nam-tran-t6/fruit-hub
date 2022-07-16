import 'package:flutter_fruit_hub/src/models/collection_fruit_model.dart';
import 'package:flutter_fruit_hub/src/repositories/collection_menu_repository.dart';
import 'package:flutter_fruit_hub/src/services/collection_menu_api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCollectionMenuApiService extends Mock implements CollectionMenuApiService {}

void main() {
  group('Collection Menu Repository', () {
    late MockCollectionMenuApiService serviceMock;
    late CollectionMenuRepositoryImpl repository;

    setUp(() {
      serviceMock = MockCollectionMenuApiService();
      repository = CollectionMenuRepositoryImpl();
      repository.service = serviceMock;
    });

    test('instantiates internal CollectionMenuRepositoryImpl when not injected', () {
      expect(CollectionMenuRepositoryImpl(), isNotNull);
    });

    test('test empty Fetch List Menu', () async {
      when(() => serviceMock.fetchListMenu()).thenAnswer((_) async => List.empty());
      var result = await repository.fetchListMenu();
      expect(result.isEmpty, true);
      verify(() => serviceMock.fetchListMenu()).called(1);
    });

    test('test Fetch List Menu success', () async {
      List<CollectionFruitMenu> _listMenu = [];
      for (int i = 0; i < 5; i++) {
        _listMenu.add(CollectionFruitMenu('Menu $i'));
      }
      when(() => serviceMock.fetchListMenu()).thenAnswer((_) async => _listMenu);
      var result = await repository.fetchListMenu();
      expect(result.length, 5);
      verify(() => serviceMock.fetchListMenu()).called(1);
    });
  });
}
