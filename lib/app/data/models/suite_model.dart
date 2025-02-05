import 'dart:convert';

import 'package:challenge_guia/app/data/models/category_item_model.dart';
import 'package:challenge_guia/app/data/models/item_model.dart';
import 'package:challenge_guia/app/data/models/period_model.dart';

class SuiteModel {
  final String name;
  final int amount;
  final bool showAvailableAmount;
  final List<String> photosUrls;
  final List<ItemModel> items;
  final List<CategoryItemModel> categoryItems;
  final List<PeriodModel> periods;

  SuiteModel({
    required this.name,
    required this.amount,
    required this.showAvailableAmount,
    required this.photosUrls,
    required this.items,
    required this.categoryItems,
    required this.periods,
  });

  factory SuiteModel.fromMap(Map<String, dynamic> map) {
    return SuiteModel(
      name: map['nome'],
      amount: map['qtd'],
      showAvailableAmount: map['exibirQtdDisponiveis'],
      photosUrls: List<String>.from(map['fotos']),
      items:
          List<ItemModel>.from(map['itens']?.map((x) => ItemModel.fromMap(x))),
      categoryItems: List<CategoryItemModel>.from(
          map['categoriaItens']?.map((x) => CategoryItemModel.fromMap(x))),
      periods: List<PeriodModel>.from(
          map['periodos']?.map((x) => PeriodModel.fromMap(x))),
    );
  }

  factory SuiteModel.fromJson(String source) =>
      SuiteModel.fromMap(json.decode(source));
}
