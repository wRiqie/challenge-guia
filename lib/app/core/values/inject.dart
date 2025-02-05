import 'package:challenge_guia/app/data/data_sources/motels_data_source.dart';
import 'package:challenge_guia/app/data/data_sources/motels_data_source_imp.dart';
import 'package:challenge_guia/app/data/repositories/motels_repository.dart';
import 'package:challenge_guia/app/data/services/http/http_service.dart';
import 'package:challenge_guia/app/data/services/http/http_service_imp.dart';
import 'package:get_it/get_it.dart';

class Inject {
  static void init() {
    final getIt = GetIt.I;

    // Http
    getIt.registerLazySingleton<HttpService>(() => HttpServiceImp());

    // datasources
    getIt.registerLazySingleton<MotelsDataSource>(
        () => MotelsDataSourceImp(getIt()));

    // repositories
    getIt.registerLazySingleton<MotelsRepository>(
        () => MotelsRepository(getIt()));
  }
}
