import 'dart:async';

import 'package:flutter_fruit_hub/src/models/collection_fruit_model.dart';
import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/repositories/fruit_list_repository.dart';

import 'collection_fruits_event.dart';
import 'collection_fruits_state.dart';

abstract class CollectionFruitBloc {
  void loadFruitsByCollectionMenu(CollectionFruitMenu menu);
}

class CollectionFruitBlocImpl implements CollectionFruitBloc {
  var repository = FruitListRepositoryImpl();

  List<FruitItem> _fruits = [];
  var _state = CollectionFruitState.init();

  get state => _state;

  final _eventController = StreamController<CollectionFruitEvent>();

  final _stateController = StreamController<CollectionFruitState<List<FruitItem>>>();

  CollectionFruitBlocImpl() {
    _eventController.stream.listen((event) {
      _mappingEventToState(event);
    });
  }

  void _mappingEventToState(CollectionFruitEvent event) {
    if (event is LoadListFruitEvent) {
      _fruits = event.listFruit;
      _stateController.sink.add(CollectionFruitState.complete(_fruits));
    } else if (event is FetchListFruitByMenuEvent) {
      _stateController.sink.add((CollectionFruitState.loading()));
      loadFruitsByCollectionMenu(event.menu);
    } else if (event is ShowErrorMessageEvent) {
      _stateController.sink.add((CollectionFruitState.error(event.message)));
    }
  }

  Stream<CollectionFruitState<List<FruitItem>>> getStateStream() {
    return _stateController.stream;
  }

  Stream getEventStream() {
    return _eventController.stream;
  }

  @override
  void loadFruitsByCollectionMenu(CollectionFruitMenu menu) async {
    //Call api here
    var menuParam = menu.title.toLowerCase().replaceAll(new RegExp(r"\s+"), "");
    var response = await repository.fetchListFruit(menuParam);
    _fruits = response.list;
    //Trigger widget get new data
    addEvent(LoadListFruitEvent(_fruits));
  }

  void addEvent(CollectionFruitEvent event) {
    _eventController.sink.add(event);
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
