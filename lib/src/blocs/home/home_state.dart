abstract class HomeState {}

class HomeStateInit extends HomeState {
  String welcomeMessage;
  String topCollectionTitle;

  HomeStateInit(this.welcomeMessage, this.topCollectionTitle) : super();
}

class HomeStateNewConfig extends HomeState {
  String welcomeMessage;
  String topCollectionTitle;

  HomeStateNewConfig(this.welcomeMessage, this.topCollectionTitle) : super();
}
