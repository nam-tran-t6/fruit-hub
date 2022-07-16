import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/bloc_provs/collection_bloc_provider.dart';
import 'package:flutter_fruit_hub/src/blocs/collection_fruits/list_fruits/collection_fruits_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/collection_fruits/menu/collection_menu_bloc.dart';

import 'collection_fruit_list_widget.dart';
import 'collection_menu_list_widget.dart';

class CollectionFruitsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var blocProvider = CollectionBlocProvider(
      menuBloc: CollectionMenuBlocImpl(),
      fruitsBloc: CollectionFruitBlocImpl(),
      child: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CollectionFruitMenuWidget(),
              CollectionFruitListWidget(),
            ],
          ),
        ),
      ),
    );
    blocProvider.constraintsEvent();
    return blocProvider;
  }
}
