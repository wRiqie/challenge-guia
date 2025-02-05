import 'dart:convert';

class PeriodModel {
  final String formattedTime;
  final num baseValue;
  final num totalValue;
  final bool hasCortesy;
  final num? discount;

  PeriodModel({
    required this.formattedTime,
    required this.baseValue,
    required this.totalValue,
    required this.hasCortesy,
    required this.discount,
  });

  factory PeriodModel.fromMap(Map<String, dynamic> map) {
    return PeriodModel(
      formattedTime: map['tempoFormatado'],
      baseValue: map['valor'],
      totalValue: map['valorTotal'],
      hasCortesy: map['temCortesia'],
      discount: map['desconto']?['desconto'],
    );
  }

  factory PeriodModel.fromJson(String source) => PeriodModel.fromMap(json.decode(source));
}
