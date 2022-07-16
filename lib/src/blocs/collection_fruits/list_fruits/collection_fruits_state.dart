class CollectionFruitState<T> {
  late CollectionFruitStatus status;
  late T data;
  late String errorMessage;

  CollectionFruitState.loading() : status = CollectionFruitStatus.LOADING;

  CollectionFruitState.complete(this.data) : status = CollectionFruitStatus.COMPLETED;

  CollectionFruitState.error(this.errorMessage) : status = CollectionFruitStatus.ERROR;

  CollectionFruitState.init() : status = CollectionFruitStatus.INIT;
}

enum CollectionFruitStatus { INIT, LOADING, COMPLETED, ERROR }
