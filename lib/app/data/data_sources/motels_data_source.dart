import 'package:challenge_guia/app/data/models/motel_model.dart';
import 'package:challenge_guia/app/data/models/paginable_model.dart';

abstract class MotelsDataSource {
  Future<PaginableModel<MotelModel>> getAllPaginated();
}