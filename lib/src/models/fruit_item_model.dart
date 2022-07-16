import 'package:equatable/equatable.dart';

class FruitList extends Equatable {
  FruitList({required this.list});

  final List<FruitItem> list;

  factory FruitList.fromJson(Map<String, dynamic> json) => FruitList(
        list: List<FruitItem>.from(
          json['list'].map(
            (x) => FruitItem.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        'list': List<dynamic>.from(
          list.map(
            (x) => x.toJson(),
          ),
        ),
      };

  @override
  List<Object?> get props => [list];
}

class FruitItem extends Equatable {
  late final int? availableQuantity;
  late final String? collection;
  late final String? color;
  late final String? comboId;
  late final String? currency;
  late final List<String>? imageUrl;
  late final String? introduction;
  late final bool? isFavorite;
  late final String? name;
  late final String? nutrition;
  late final num? price;

  FruitItem({
    this.availableQuantity,
    this.collection,
    this.color,
    this.comboId,
    this.currency,
    this.imageUrl,
    this.introduction,
    this.isFavorite,
    this.name,
    this.nutrition,
    this.price,
  });

  FruitItem.fromJson(Map<String, dynamic> json) {
    availableQuantity = json['availableQuantity'] ?? null;
    collection = json['collection'] ?? null;
    color = json['color'] ?? null;
    comboId = json['comboId'] ?? '';
    currency = json['currency'] ?? null;
    imageUrl = List.from(json['imageUrl']);
    introduction = json['introduction'] ?? null;
    isFavorite = json['isFavorite'] ?? null;
    name = json['name'] ?? null;
    nutrition = json['nutrition'] ?? null;
    price = json['price'] ?? null;
  }

  Map<String, dynamic> toJson() {
    var data = new Map<String, dynamic>();
    data['availableQuantity'] = this.availableQuantity;
    data['collection'] = this.collection;
    data['color'] = this.color;
    data['comboId'] = this.comboId;
    data['currency'] = this.currency;
    data['imageUrl'] = this.imageUrl;
    data['introduction'] = this.introduction;
    data['isFavorite'] = this.isFavorite;
    data['name'] = this.name;
    data['nutrition'] = this.nutrition;
    data['price'] = this.price;
    return data;
  }

  FruitItem.fromEntity(Map<String, dynamic> entity)
      : availableQuantity = entity['availableQuantity'],
        collection = entity['collection'],
        color = entity['color'],
        comboId = entity['comboId'],
        currency = entity['currency'],
        introduction = entity['introduction'],
        isFavorite = entity['isFavorite'] == 1 ? true : false,
        name = entity['name'],
        imageUrl = (entity['imageUrl']).toString().split(';'),
        nutrition = entity['nutrition'],
        price = entity['price'];

  @override
  List<Object?> get props => [
        availableQuantity,
        collection,
        color,
        comboId,
        currency,
        imageUrl,
        introduction,
        isFavorite,
        name,
        nutrition,
        price
      ];
}
