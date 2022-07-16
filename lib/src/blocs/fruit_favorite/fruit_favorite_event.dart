abstract class FruitFavoriteEvent {}

class ToggleFruitItemFavorite extends FruitFavoriteEvent {
  final bool currentFavoriteState;

  ToggleFruitItemFavorite({required this.currentFavoriteState});
}
