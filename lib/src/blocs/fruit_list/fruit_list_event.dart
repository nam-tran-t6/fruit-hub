abstract class FruitListEvent {}

class FruitListFetchRequest extends FruitListEvent {
  final String collectionName;

  FruitListFetchRequest({required this.collectionName});
}
