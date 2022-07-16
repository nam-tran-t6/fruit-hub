import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_favorite/fruit_favorite_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_favorite/fruit_favorite_event.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_favorite/fruit_favorite_state.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/app_icons.dart';

class AppFavoriteButton extends StatefulWidget {
  final bool initialFavoriteState;

  AppFavoriteButton({required this.initialFavoriteState});

  @override
  _AppFavoriteButtonState createState() => _AppFavoriteButtonState();
}

class _AppFavoriteButtonState extends State<AppFavoriteButton>
    with AutomaticKeepAliveClientMixin<AppFavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FruitFavoriteBloc(),
      child: BlocBuilder<FruitFavoriteBloc, FruitFavoriteState>(
        builder: (context, state) {
          if (state is FruitItemInitialFavoriteState) {
            return Material(
              color: Colors.transparent,
              elevation: 0,
              child: IconButton(
                iconSize: 22,
                onPressed: () {
                  BlocProvider.of<FruitFavoriteBloc>(context).add(ToggleFruitItemFavorite(
                      currentFavoriteState: !widget.initialFavoriteState));
                },
                icon: widget.initialFavoriteState
                    ? AppIcons.favorite_texas_rose_widget
                    : AppIcons.favorite_outline_texas_rose_widget,
              ),
            );
          }
          if (state is FruitItemCurrentFavoriteState) {
            return IconButton(
              iconSize: 22,
              onPressed: () {
                BlocProvider.of<FruitFavoriteBloc>(context).add(
                    ToggleFruitItemFavorite(currentFavoriteState: !state.isFavorite));
              },
              icon: state.isFavorite
                  ? AppIcons.favorite_texas_rose_widget
                  : AppIcons.favorite_outline_texas_rose_widget,
            );
          }
          return Container();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
