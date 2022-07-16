import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/blocs/collection_fruits/list_fruits/collection_fruits_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/collection_fruits/list_fruits/collection_fruits_event.dart';
import 'package:flutter_fruit_hub/src/blocs/collection_fruits/menu/collection_menu_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/collection_fruits/menu/collection_menu_event.dart';

class CollectionBlocProvider extends InheritedWidget {
  final CollectionMenuBlocImpl menuBloc;
  final CollectionFruitBlocImpl fruitsBloc;

  const CollectionBlocProvider({
    Key? key,
    required Widget child,
    required this.menuBloc,
    required this.fruitsBloc,
  }) : super(key: key, child: child);

  static CollectionBlocProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CollectionBlocProvider>();
  }

  @override
  bool updateShouldNotify(CollectionBlocProvider old) {
    return true;
  }

  void constraintsEvent() {
    menuBloc.getEventStream().listen((event) {
      if (event is SelectCollectionEvent) {
        fruitsBloc.addEvent(FetchListFruitByMenuEvent(event.menuSelected));
      }
    });
  }
}
