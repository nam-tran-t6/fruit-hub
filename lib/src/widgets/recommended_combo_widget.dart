import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_list/fruit_list_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_list/fruit_list_event.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_list/fruit_list_state.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_text_styles.dart';
import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/repositories/fruit_list_repository.dart';
import 'package:flutter_fruit_hub/src/widgets/app_favorite_button.dart';
import 'package:flutter_fruit_hub/src/widgets/fruit_item_widget.dart';

class RecommendedComboWidget extends StatelessWidget {
  final String text;

  const RecommendedComboWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: AppTextStyles.kBoldPortGore24,
          ),
          SizedBox(
            height: 24,
          ),
          SizedBox(
            width: double.infinity,
            height: 183,
            child: BlocProvider(
              create: (context) => FruitListBloc(FruitListRepositoryImpl()),
              child: BlocBuilder<FruitListBloc, FruitListState>(
                builder: (context, state) {
                  if (state is FruitListInitial) {
                    BlocProvider.of<FruitListBloc>(context)
                        .add(FruitListFetchRequest(collectionName: 'recommended'));
                  }
                  if (state is FruitListLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is FruitListLoadError) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: AppTextStyles.kNormalCinnabar14,
                      ),
                    );
                  }
                  if (state is FruitListLoaded) {
                    List<FruitItem> recommendedList = state.fruitListData.list;
                    return ListView.builder(
                      addAutomaticKeepAlives: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.fruitListData.list.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(right: 23),
                          child: FruitItemWidget(
                            width: 152,
                            height: 183,
                            fruitItem: recommendedList[index],
                            favoriteButton: AppFavoriteButton(
                                initialFavoriteState: recommendedList[index].isFavorite!),
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
