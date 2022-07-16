import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_item/fruit_item_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_item/fruit_item_event.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_item/fruit_item_state.dart';
import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/repositories/fruit_item_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

const validComboId = 'JEWPz';
const invalidComboId = 'JEWPzz';

class MockFruitItemRepository extends Mock implements FruitItemRepository {}

void main() {
  group('FruitItem details bloc test', () {
    late FruitItemRepository mockFruitItemRepository;
    late FruitItemBloc fruitItemBloc;
    FruitItem mockFruitItem = FruitItem(
      availableQuantity: 15,
      collection: 'Recommended',
      color: '#F1EFF6',
      comboId: 'JEWPz',
      currency: '\$',
      imageUrl: [
        'https://fruit-hub.s3-us-west-2.amazonaws.com/Combo/BloodOrangeAvocadoSalad.png',
        'https://fruit-hub.s3-us-west-2.amazonaws.com/Combo/ApplePecanSalad.png',
        'https://fruit-hub.s3-us-west-2.amazonaws.com/Combo/BlueberryCantaloupeSalad.png',
        'https://fruit-hub.s3-us-west-2.amazonaws.com/Combo/FruitWithPoppySeedDressing.png',
        'https://fruit-hub.s3-us-west-2.amazonaws.com/Combo/GlazedFruitMedley.png'
      ],
      introduction:
          'The simple citrus and poppy seed dressing in this fruit medley really dresses up the refreshing mix of berries and melon.',
      isFavorite: false,
      name: 'Blueberry Cantaloupe Salad',
      nutrition:
          '76 calories, 1g fat (0 saturated fat), 1mg cholesterol, 24mg sodium, 17g carbohydrate (15g sugars, 1g fiber), 2g protein.',
      price: 1400,
    );

    setUp(() {
      mockFruitItemRepository = MockFruitItemRepository();
      fruitItemBloc = FruitItemBloc(mockFruitItemRepository);
      when(() => mockFruitItemRepository.fetchFruitItem(validComboId))
          .thenAnswer((_) async => mockFruitItem);
    });

    tearDown(() async {
      fruitItemBloc.close();
    });

    test('Should trigger [FruitItemInitial] state when initialize the [FruitItemBloc]',
        () {
      expect(fruitItemBloc.state, FruitItemInitial());
    });

    blocTest<FruitItemBloc, FruitItemState>(
      'Should emit [] when no event is added',
      build: () => fruitItemBloc,
      expect: () => [],
    );

    blocTest<FruitItemBloc, FruitItemState>(
      'Should call fetchFruitItem with valid comboId',
      build: () => fruitItemBloc,
      act: (bloc) => bloc.add(FruitItemFetchRequest(id: validComboId)),
      verify: (_) {
        verify(() => mockFruitItemRepository.fetchFruitItem(validComboId)).called(1);
      },
    );

    blocTest<FruitItemBloc, FruitItemState>(
      'Should emit [FruitItemLoading, FruitItemLoaded] when FruitItemFetchRequest succeeds',
      build: () => fruitItemBloc,
      act: (bloc) => bloc.add(FruitItemFetchRequest(id: validComboId)),
      expect: () => [FruitItemLoading(), FruitItemLoaded(fruitItemDetail: mockFruitItem)],
    );

    blocTest<FruitItemBloc, FruitItemState>(
      'Should emit [FruitItemLoading, FruitItemLoadError] when FruitItemFetchRequest fails due to invalid comboId',
      build: () => fruitItemBloc,
      act: (bloc) => bloc.add(FruitItemFetchRequest(id: invalidComboId)),
      expect: () => [FruitItemLoading(), FruitItemLoadError('An error occurs!')],
    );
  });
}
