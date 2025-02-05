import 'dart:convert';

import 'package:challenge_guia/app/data/data_sources/motels_data_source.dart';
import 'package:challenge_guia/app/data/models/motel_model.dart';
import 'package:challenge_guia/app/data/models/paginable_model.dart';
import 'package:challenge_guia/app/data/services/http/http_service.dart';

class MotelsDataSourceImp implements MotelsDataSource {
  final HttpService _httpService;

  MotelsDataSourceImp(this._httpService);

  @override
  Future<PaginableModel<MotelModel>> getAllPaginated() async {
    final response = await _httpService.get('/b/1IXK');
    var bodyDecoded = jsonDecode(utf8.decode(response.bodyBytes));
    return PaginableModel.fromMap(bodyDecoded, MotelModel.fromMap);
  }
}