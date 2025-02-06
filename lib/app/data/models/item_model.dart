class ItemModel {
  final String name;

  ItemModel({required this.name});

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      name: map['nome'],
    );
  }
}
