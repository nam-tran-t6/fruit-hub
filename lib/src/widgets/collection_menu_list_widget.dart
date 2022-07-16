import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/bloc_provs/collection_bloc_provider.dart';
import 'package:flutter_fruit_hub/src/blocs/collection_fruits/menu/collection_menu_state.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_text_styles.dart';
import 'package:flutter_fruit_hub/src/models/collection_fruit_model.dart';

class CollectionFruitMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = CollectionBlocProvider.of(context)!.menuBloc;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: SizedBox(
          height: 50,
          child: StreamBuilder<CollectionMenuState>(
            stream: bloc.getStateStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.listMenu.isNotEmpty) {
                var menus = snapshot.data!.listMenu;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: menus.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          bloc.selectMenu(menus[index]);
                        },
                        child: Padding(
                          padding: _getEdgeByIndex(index),
                          child: Text(
                            menus[index].title,
                            textAlign: TextAlign.end,
                            style: _getStyleBySelectedMenu(menus[index]),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return GestureDetector(
                    onTap: () {
                      bloc.fetchListMenu();
                    },
                    child: Center(child: Text(snapshot.data?.errorMessage ?? '')));
              }
            },
          ),
        ),
      ),
    );
  }

  EdgeInsets _getEdgeByIndex(int index) {
    if (index == 0) {
      return EdgeInsets.only(left: 0, right: 16);
    }
    return EdgeInsets.only(left: 16, right: 16);
  }

  TextStyle _getStyleBySelectedMenu(CollectionFruitMenu menu) {
    return menu.isSelected
        ? AppTextStyles.kNormalPortGore24
        : AppTextStyles.kNormalAmethystSmoke16;
  }
}
