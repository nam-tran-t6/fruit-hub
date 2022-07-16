import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_basket/my_basket_cubit.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_item/fruit_item_event.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_item/fruit_item_state.dart';
import 'package:flutter_fruit_hub/src/repositories/fruit_item_repository.dart';
import 'package:flutter_fruit_hub/src/mixin/logger_service_mixin.dart';

class FruitItemBloc extends Bloc<FruitItemEvent, FruitItemState> with LoggerBlocMixin {
  FruitItemRepository fruitItemRepository;

  FruitItemBloc(this.fruitItemRepository) : super(FruitItemInitial());

  @override
  Stream<FruitItemState> mapEventToState(FruitItemEvent event) async* {
    switch (event.runtimeType) {
      case FruitItemFetchRequest:
        FruitItemFetchRequest fetchFruitItem = event as FruitItemFetchRequest;
        yield FruitItemLoading();
        try {
          var fruitItemData = await fruitItemRepository.fetchFruitItem(fetchFruitItem.id!);
          yield FruitItemLoaded(fruitItemDetail: fruitItemData);
        } catch (e) {
          yield FruitItemLoadError('An error occurs!');
        }
        break;
      case FruitItemEventAddToBasket:
        FruitItemEventAddToBasket addToBasket = event as FruitItemEventAddToBasket;
        BlocProvider.of<MyBasketCubit>(addToBasket.context)
            .addItemToBasket(addToBasket.itemAddedBasketModel);
        break;
    }
  }
}
