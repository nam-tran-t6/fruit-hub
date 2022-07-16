abstract class FruitFavoriteState {}

class FruitItemInitialFavoriteState extends FruitFavoriteState {}

class FruitItemCurrentFavoriteState extends FruitFavoriteState {
  final bool isFavorite;

  FruitItemCurrentFavoriteState({required this.isFavorite});
}
