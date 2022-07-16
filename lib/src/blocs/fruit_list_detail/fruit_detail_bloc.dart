import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_basket/my_basket_cubit.dart';
import 'package:flutter_fruit_hub/src/mixin/logger_service_mixin.dart';

import 'fruit_list_detail_event.dart';
import 'fruit_list_detail_state.dart';

class FruitDetailBloc extends Bloc<FruitDetailEvent, FruitDetailState> with LoggerBlocMixin {
  FruitDetailBloc() : super(FruitDetailInitialState());
  int counter = 1;

  @override
  Stream<FruitDetailState> mapEventToState(FruitDetailEvent event) async* {
    if (event is PressedIncrementItemEvent) {
      counter++;
      emit(FruitDetailAmountState(counter));
    } else if (event is PressedDecrementItemEvent) {
      if (counter > 1) {
        counter--;
      }
      emit(FruitDetailAmountState(counter));
    } else if (event is ToggleFruitItemFavoriteEvent) {
      emit(FruitItemCurrentFavoriteState(isFavorite: !event.currentFavoriteState));
    } else if (event is PressedAddToBasketEvent) {
      var basketBloc = BlocProvider.of<MyBasketCubit>(event.context);
      var result = basketBloc.addItemToBasket(event.itemAddedBasketModel);
      if (result is AddSuccess) {
        emit(ShouldBackToHomeScreen());
      } else {
        // showSnackBar(result);
      }
    }
  }
}
