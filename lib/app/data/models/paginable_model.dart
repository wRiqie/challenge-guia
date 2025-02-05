class PaginableModel<T> {
  List<T> items;
  int page;
  int size;

  PaginableModel({
    required this.items,
    this.page = 1,
    this.size = 20,
  });

  factory PaginableModel.clean() => PaginableModel<T>(items: []);

  factory PaginableModel.fromMap(
      Map<String, dynamic> map, T Function(Map<String, dynamic>) fromMap) {
    map = map['data'];
    return PaginableModel(
      page: map['pagina'],
      size: map['qtdPorPagina'],
      items: (map['moteis'] as List).map((e) => fromMap(e)).toList(),
    );
  }

  int get nextPage => page + 1;

  bool get isNotEmpty => items.isNotEmpty;
  bool get isEmpty => items.isEmpty;

  int indexOf(T value) {
    return items.indexOf(value);
  }

  PaginableModel<T> copyWith({
    List<T>? items,
    int? page,
    int? size,
  }) {
    return PaginableModel<T>(
      items: items ?? this.items,
      page: page ?? this.page,
      size: size ?? this.size,
    );
  }
}