import 'package:challenge_guia/app/data/models/default_response_model.dart';
import 'package:challenge_guia/app/data/models/error_model.dart';
import 'package:challenge_guia/app/data/services/execute_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExecuteService.tryExecuteAsync', () {
    test(
        'Deve retornar DefaultResponseModel com os dados quando a execução for bem-sucedida',
        () async {
      // Arrange
      Future<int?> mockFunction() async => 42;

      // Act
      final result = await ExecuteService.tryExecuteAsync(mockFunction);

      // Assert
      expect(result, isA<DefaultResponseModel<int>>());
      expect(result.data, 42);
      expect(result.error, isNull);
    });

    test(
        'Deve retornar DefaultResponseModel com erro quando ErrorModel for lançado',
        () async {
      // Arrange
      Future<int?> mockFunction() async => throw ErrorModel("Erro simulado");

      // Act
      final result = await ExecuteService.tryExecuteAsync(mockFunction);

      // Assert
      expect(result, isA<DefaultResponseModel<int>>());
      expect(result.error, isA<ErrorModel>());
      expect(result.error?.message, "Erro simulado");
      expect(result.data, isNull);
    });
  });
}
