import 'package:challenge_guia/app/data/models/suite_model.dart';

class MotelModel {
  final String name;
  final String logoUrl;
  final String address;
  final num distance;
  final int favoriteAmount;
  final List<SuiteModel> suites;

  MotelModel({
    required this.name,
    required this.logoUrl,
    required this.address,
    required this.distance,
    required this.favoriteAmount,
    this.suites = const [],
  });

  factory MotelModel.fromMap(Map<String, dynamic> map) {
    return MotelModel(
      name: map['fantasia'] ?? '',
      logoUrl: map['logo'] ?? '',
      address: map['bairro'] ?? '',
      distance: map['distancia'] ?? 0,
      favoriteAmount: map['qtdFavoritos'],
      suites: List<SuiteModel>.from(
          map['suites']?.map((x) => SuiteModel.fromMap(x))),
    );
  }
}
