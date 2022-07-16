import 'fruit_item_model.dart';

class ItemAddedBasketModel {
  FruitItem fruitItem;
  int quantity;

  ItemAddedBasketModel({
    required this.fruitItem,
    this.quantity = 0,
  });

  Map<String, dynamic> toJson() {
    var data = new Map<String, dynamic>();
    data['availableQuantity'] = this.fruitItem.availableQuantity;
    data['collection'] = this.fruitItem.collection;
    data['color'] = this.fruitItem.color;
    data['comboId'] = this.fruitItem.comboId;
    data['currency'] = this.fruitItem.currency;
    data['imageUrl'] = this.fruitItem.imageUrl?.join(';');
    data['introduction'] = this.fruitItem.introduction;
    data['isFavorite'] = this.fruitItem.isFavorite;
    data['name'] = this.fruitItem.name;
    data['nutrition'] = this.fruitItem.nutrition;
    data['price'] = this.fruitItem.price;
    data['quantity'] = this.quantity;
    return data;
  }

  Map<String, dynamic> toEntity() {
    var data = new Map<String, dynamic>();
    data['availableQuantity'] = this.fruitItem.availableQuantity;
    data['collection'] = this.fruitItem.collection;
    data['color'] = this.fruitItem.color;
    data['comboId'] = this.fruitItem.comboId;
    data['currency'] = this.fruitItem.currency;
    data['imageUrl'] = this.fruitItem.imageUrl?.join(';');
    data['introduction'] = this.fruitItem.introduction;
    data['isFavorite'] = this.fruitItem.isFavorite == true ? 1 : 0;
    data['name'] = this.fruitItem.name;
    data['nutrition'] = this.fruitItem.nutrition;
    data['price'] = this.fruitItem.price;
    data['quantity'] = this.quantity;
    return data;
  }
}
