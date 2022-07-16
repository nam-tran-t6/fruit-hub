import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/bloc_provs/collection_bloc_provider.dart';
import 'package:flutter_fruit_hub/src/blocs/collection_fruits/list_fruits/collection_fruits_state.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_box_decoration_styles.dart';
import 'package:flutter_fruit_hub/src/widgets/app_favorite_button.dart';
import 'package:flutter_fruit_hub/src/widgets/fruit_item_widget.dart';

class CollectionFruitListWidget extends StatelessWidget {
  final _widthFruitView = 152.0;
  final _heightFruitView = 170.0;

  @override
  Widget build(BuildContext context) {
    var _bloc = CollectionBlocProvider.of(context)!.fruitsBloc;
    return Container(
      child: SizedBox(
        height: _heightFruitView,
        child: SafeArea(
          child: StreamBuilder<CollectionFruitState>(
              stream: _bloc.getStateStream(),
              initialData: _bloc.state,
              builder: (context, state) {
                if (state.hasData) {
                  switch (state.data!.status) {
                    case CollectionFruitStatus.INIT:
                      break;
                    case CollectionFruitStatus.LOADING:
                      return Center(
                        child: Container(
                          width: _widthFruitView,
                          height: _heightFruitView,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                          decoration:
                              AppBoxDecorStyles.kShadowMineShaft005Radius16.copyWith(
                            color: Color.fromRGBO(255, 255, 255, 0.5),
                          ),
                        ),
                      );

                    case CollectionFruitStatus.COMPLETED:
                      {
                        var listFruits = state.data!.data;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listFruits.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(left: 0, right: 16),
                              child: FruitItemWidget(
                                width: _widthFruitView,
                                height: _heightFruitView,
                                fruitItem: listFruits[index],
                                favoriteButton: AppFavoriteButton(
                                    initialFavoriteState: listFruits[index].isFavorite!),
                              ),
                            );
                          },
                        );
                      }
                    case CollectionFruitStatus.ERROR:
                      return Center(child: Text(Strings.empty_fruit_in_this_collection));
                  }
                }
                return const Center(child: Text(Strings.please_select_a_menu));
              }),
        ),
      ),
    );
  }
}
