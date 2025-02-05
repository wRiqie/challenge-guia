import 'package:challenge_guia/app/data/data_sources/motels_data_source.dart';
import 'package:challenge_guia/app/data/models/default_response_model.dart';
import 'package:challenge_guia/app/data/models/motel_model.dart';
import 'package:challenge_guia/app/data/models/paginable_model.dart';
import 'package:challenge_guia/app/data/services/execute_service.dart';

class MotelsRepository {
  final MotelsDataSource _motelsDataSource;

  MotelsRepository(this._motelsDataSource);

  Future<DefaultResponseModel<PaginableModel<MotelModel>>> getAllPaginated() {
    return ExecuteService.tryExecuteAsync(
        () => _motelsDataSource.getAllPaginated());
  }
}
