import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_list/fruit_list_event.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_list/fruit_list_state.dart';
import 'package:flutter_fruit_hub/src/mixin/logger_service_mixin.dart';
import 'package:flutter_fruit_hub/src/repositories/fruit_list_repository.dart';

class FruitListBloc extends Bloc<FruitListFetchRequest, FruitListState> with LoggerBlocMixin {
  final FruitListRepository fruitListRepository;

  FruitListBloc(this.fruitListRepository) : super(FruitListInitial());

  @override
  Stream<FruitListState> mapEventToState(FruitListFetchRequest event) async* {
    switch (event.runtimeType) {
      case FruitListFetchRequest:
        FruitListFetchRequest fetchFruitList = event;
        yield FruitListLoading();
        try {
          var fruitListData =
              await fruitListRepository.fetchListFruit(fetchFruitList.collectionName);
          yield FruitListLoaded(fruitListData: fruitListData);
        } catch (e) {
          yield FruitListLoadError('Error getting Fruit List data!');
        }
        break;
    }
  }
}
