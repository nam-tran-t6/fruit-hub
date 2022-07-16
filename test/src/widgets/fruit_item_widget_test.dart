import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_item/fruit_item_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_item/fruit_item_event.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_item/fruit_item_state.dart';
import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/repositories/fruit_item_repository.dart';
import 'package:flutter_fruit_hub/src/services/fruit_item_service.dart';
import 'package:flutter_fruit_hub/src/widgets/app_favorite_button.dart';
import 'package:flutter_fruit_hub/src/widgets/fruit_item_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import '../mocks/mock_image_http.dart';

class MockFruitItemBloc extends MockBloc<FruitItemEvent, FruitItemState>
    implements FruitItemBloc {}

class MockFruitItemRepository extends Mock implements FruitItemRepository {}

class MockFruitItemApiService extends Mock implements FruitItemApiService {}

class FakeFruitItemState extends Fake implements FruitItemState {}

class FakeFruitItemEvent extends Fake implements FruitItemEvent {}

const comboId = 'JEWPz';

void main() {
  late FruitItemBloc fruitItemBloc;
  late FruitItemApiService fruitItemApiService;
  FruitItem fruitItem = FruitItem(
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
      price: 1400);

  setUpAll(() {
    registerFallbackValue(FakeFruitItemEvent());
    registerFallbackValue<FakeFruitItemState>(FakeFruitItemState());
    registerFallbackValue<Uri>(Uri());
  });

  setUp(() {
    fruitItemBloc = MockFruitItemBloc();
    fruitItemApiService = MockFruitItemApiService();
    when(() => fruitItemApiService.fetchFruitItem(comboId))
        .thenAnswer((_) async => fruitItem);
  });

  tearDown(() {
    fruitItemBloc.close();
  });

  group('FruitItemWidget on Home screen', () {
    testWidgets(
        'Should display the FruitItemWidget name when state is [FruitItemInitial]',
        (WidgetTester tester) async {
      when(() => fruitItemBloc.state)
          .thenAnswer((realInvocation) => FruitItemInitial());
      await HttpOverrides.runZoned<Future<void>>(() async {
        await tester.pumpWidget(Builder(builder: (contextA) {
          return BlocProvider(
            create: (context) => fruitItemBloc,
            child: MaterialApp(
              home: FruitItemWidget(
                width: 152,
                height: 183,
                fruitItem: fruitItem,
                favoriteButton: AppFavoriteButton(
                    initialFavoriteState: fruitItem.isFavorite!),
              ),
            ),
          );
        }));
        final fruitItemName = find.text(fruitItem.name!, skipOffstage: false);
        expect(fruitItemName, findsOneWidget);
      }, createHttpClient: createMockImageHttpClient);
    });
  });

  testWidgets(
      'Should display the FruitItemWidget favorite icon when state is [FruitItemLoaded]',
      (WidgetTester tester) async {
    when(() => fruitItemBloc.state).thenAnswer(
        (realInvocation) => FruitItemLoaded(fruitItemDetail: fruitItem));
    await HttpOverrides.runZoned<Future<void>>(() async {
      await tester.pumpWidget(Builder(builder: (contextA) {
        return BlocProvider(
          create: (context) => fruitItemBloc,
          child: MaterialApp(
            home: FruitItemWidget(
              width: 152,
              height: 183,
              fruitItem: fruitItem,
              favoriteButton: AppFavoriteButton(
                initialFavoriteState: fruitItem.isFavorite!,
              ),
            ),
          ),
        );
      }));
      final fruitItemFavoriteIcon =
          find.byType(AppFavoriteButton, skipOffstage: false);
      expect(fruitItemFavoriteIcon, findsOneWidget);
    }, createHttpClient: createMockImageHttpClient);
  });
}
