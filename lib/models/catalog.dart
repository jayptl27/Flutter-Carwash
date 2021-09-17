import 'dart:convert';

class CatalogModel {
  static List<Item> items;

  //get Item by ID
  Item getById(int id) =>
      items.firstWhere((element) => element.id == id, orElse: null);

  //get Item by position
  Item getByPosition(int pos) => items[pos];
}

class Item {
  final num id;
  final String name;
  final String desc;
  final num price;
  final String color;
  final String desctwo;
  final String image;
  final String duration;

  Item({
    this.id,
    this.name,
    this.desc,
    this.price,
    this.color,
    this.image,
    this.desctwo,
    this.duration,
  });

  Item copyWith({
    num id,
    String name,
    String desc,
    num price,
    String color,
    String desctw0,
    String image,
    String duration,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      desctwo: desctwo ?? this.desctwo,
      price: price ?? this.price,
      color: color ?? this.color,
      image: image ?? this.image,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'price': price,
      'color': color,
      'image': image,
      'desctwo': desctwo,
      'duration': duration,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Item(
      id: map['id'],
      name: map['name'],
      desc: map['desc'],
      price: map['price'],
      color: map['color'],
      desctwo: map['desctwo'],
      image: map['image'],
      duration: map['duration'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Item(id: $id, name: $name, desc: $desc, price: $price, color: $color, image: $image, desctwo: $desctwo, duration: $duration)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Item &&
        o.id == id &&
        o.name == name &&
        o.desc == desc &&
        o.price == price &&
        o.color == color &&
        o.desctwo == desctwo &&
        o.image == image &&
        o.duration == duration;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        desc.hashCode ^
        price.hashCode ^
        color.hashCode ^
        desctwo.hashCode ^
        duration.hashCode ^
        image.hashCode;
  }
}
