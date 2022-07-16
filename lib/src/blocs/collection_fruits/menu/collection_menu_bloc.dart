import 'dart:async';

import 'package:flutter_fruit_hub/src/constants/app_constants.dart';
import 'package:flutter_fruit_hub/src/models/collection_fruit_model.dart';
import 'package:flutter_fruit_hub/src/repositories/collection_menu_repository.dart';
import 'package:flutter_fruit_hub/src/services/base_service/base_api_exception.dart';

import 'collection_menu_event.dart';
import 'collection_menu_state.dart';

abstract class CollectionMenuBloc {
  void selectMenu(CollectionFruitMenu menuSelected);
}

class CollectionMenuBlocImpl implements CollectionMenuBloc {
  List<CollectionFruitMenu> _collectionMenus = [];
  CollectionFruitMenu? _currentMenu;
  late CollectionMenuState _state;

  get state => _state;

  late CollectionMenuRepository _menuRepository;

  //Stream receive new event
  final _eventController = StreamController.broadcast();

  //Stream receive data
  final _stateController = StreamController<CollectionMenuState>();

  CollectionMenuBlocImpl() {
    _menuRepository = CollectionMenuRepositoryImpl();
    _state = CollectionMenuState([]);
    _eventController.stream.listen((event) {
      mappingEventToState(event);
    });

    fetchListMenu();
  }

  void mappingEventToState(CollectionMenuEvent event) async {
    if (event is SelectCollectionEvent) {
      _state.menuSelect = event.menuSelected;
    } else if (event is DisplayListMenuEvent) {
      _state.listMenu = event.menus;
    } else if (event is RequestFetchListMenuEvent) {
      fetchListMenu();
    } else if (event is CollectionMenuError) {
      _state.errorMessage = event.message;
    }
    _addState(_state);
  }

  void selectMenu(CollectionFruitMenu menuSelected) {
    if (_currentMenu != null) {
      _collectionMenus[_getMenuPosition(_currentMenu!)].isSelected = false;
    }
    _currentMenu = menuSelected;
    _collectionMenus[_getMenuPosition(_currentMenu!)].isSelected = true;
    _addEvent(SelectCollectionEvent(menuSelected));
  }

  int _getMenuPosition(CollectionFruitMenu menu) {
    var position = FIRST_INDEX;
    for (int i = 0; i < _collectionMenus.length; i++) {
      if (menu.title == _collectionMenus[i].title) {
        position = i;
        break;
      }
    }
    return position;
  }

  void fetchListMenu() async {
    _addEvent(StartRequestDataEvent());
    try {
      _collectionMenus = await _menuRepository.fetchListMenu();
      if (_currentMenu == null) {
        _currentMenu = _collectionMenus[FIRST_INDEX].setDefaultSelected();
      }
      _addEvent(DisplayListMenuEvent(_collectionMenus));
      _addEvent(SelectCollectionEvent(_currentMenu!));
    } on RequestException catch (e) {
      _addEvent(CollectionMenuError(e.message));
    }
  }

  void _addEvent(CollectionMenuEvent event) {
    _eventController.sink.add(event);
  }

  void _addState(CollectionMenuState state) {
    _stateController.sink.add(_state);
  }

  Stream<CollectionMenuState> getStateStream() {
    return _stateController.stream;
  }

  Stream getEventStream() {
    return _eventController.stream;
  }

  String getMenuNameByIndex(int index) {
    return _collectionMenus[index].title;
  }

  int getMenuCount() {
    return _collectionMenus.length;
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
