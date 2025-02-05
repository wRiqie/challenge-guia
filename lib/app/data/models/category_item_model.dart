import 'dart:convert';

class CategoryItemModel {
  final String name;
  final String iconUrl;

  CategoryItemModel({
    required this.name,
    required this.iconUrl,
  });

  factory CategoryItemModel.fromMap(Map<String, dynamic> map) {
    return CategoryItemModel(
      name: map['nome'],
      iconUrl: map['icone'],
    );
  }

  factory CategoryItemModel.fromJson(String source) =>
      CategoryItemModel.fromMap(json.decode(source));
}
