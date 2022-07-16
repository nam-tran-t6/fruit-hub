import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_fruit_hub/src/mixin/logger_service_mixin.dart';
import 'fruit_favorite_event.dart';
import 'fruit_favorite_state.dart';

class FruitFavoriteBloc extends Bloc<ToggleFruitItemFavorite, FruitFavoriteState> with LoggerBlocMixin {
  FruitFavoriteBloc() : super(FruitItemInitialFavoriteState());

  @override
  Stream<FruitFavoriteState> mapEventToState(ToggleFruitItemFavorite event) async* {
    switch (event.runtimeType) {
      case ToggleFruitItemFavorite:
        yield FruitItemCurrentFavoriteState(isFavorite: event.currentFavoriteState);
        break;
      default:

    }
  }
}
