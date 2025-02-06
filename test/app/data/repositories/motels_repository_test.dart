import 'package:challenge_guia/app/data/data_sources/motels_data_source.dart';
import 'package:challenge_guia/app/data/models/default_response_model.dart';
import 'package:challenge_guia/app/data/models/error_model.dart';
import 'package:challenge_guia/app/data/models/motel_model.dart';
import 'package:challenge_guia/app/data/models/paginable_model.dart';
import 'package:challenge_guia/app/data/repositories/motels_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MotelsDataSourceMock extends Mock implements MotelsDataSource {}

void main() {
  late MotelsDataSource motelsDataSource;
  late MotelsRepository motelsRepository;

  setUp(() {
    motelsDataSource = MotelsDataSourceMock();
    motelsRepository = MotelsRepository(motelsDataSource);
  });

  group('[MotelsRepository] ->', () {
    test('Deve retornar um DefaultResponseModel de sucesso', () async {
      when(() => motelsDataSource.getAllPaginated())
          .thenAnswer((_) async => PaginableModel(items: []));

      final response = await motelsRepository.getAllPaginated();

      expect(response, isA<DefaultResponseModel<PaginableModel<MotelModel>>>());
      expect(response.isSuccess, isTrue);
      expect(response.error, isNull);
    });

    test('Deve retornar um DefaultResponseModel de erro', () async {
      when(() => motelsDataSource.getAllPaginated())
          .thenThrow(ErrorModel('Ocorreu um erro'));

      final response = await motelsRepository.getAllPaginated();

      expect(response, isA<DefaultResponseModel<PaginableModel<MotelModel>>>());
      expect(response.isSuccess, false);
      expect(response.error?.message, equals('Ocorreu um erro'));
    });
  });
}
