import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/repositories/fruit_item_repository.dart';
import 'package:flutter_fruit_hub/src/services/fruit_item_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

const validComboId = 'JEWPz';

class MockFruitItemApiService extends Mock implements FruitItemApiService {}
class MockFruitItem extends Mock implements FruitItem {}

void main() {
  group('FruitItemRepository', () {
    late FruitItemApiService mockFruitItemApiService;
    late FruitItemRepository fruitItemRepository;

    setUp(() {
      mockFruitItemApiService = MockFruitItemApiService();
      fruitItemRepository = FruitItemRepository(mockFruitItemApiService);
    });

    group('fetchFruitItem', () {
      test('Should call fetchFruitItem with comboId', () async {
        final mockFruitItem = MockFruitItem();
        when(() => mockFruitItemApiService.fetchFruitItem(validComboId)).thenAnswer(
              (_) async => mockFruitItem,
        );
        try {
          await fruitItemRepository.fetchFruitItem(validComboId);
        } catch (_) {}
        verify(() => mockFruitItemApiService.fetchFruitItem(validComboId)).called(1);
      });

      test('Should throw exception when fetchFruitItem fails', () async {
        final exception = Exception('An error occurs!');
        final mockFruitItem = MockFruitItem();
        when(() => mockFruitItemApiService.fetchFruitItem(validComboId)).thenAnswer(
              (_) async => mockFruitItem,
        );
        when(() => mockFruitItemApiService.fetchFruitItem(any())).thenThrow(exception);
        expect(
              () async => await fruitItemRepository.fetchFruitItem(validComboId),
          throwsA(exception),
        );
      });
    });
  });
}
