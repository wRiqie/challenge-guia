import 'dart:convert';

class ItemModel {
  final String name;

  ItemModel({required this.name});

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      name: map['name'],
    );
  }

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source));
}
