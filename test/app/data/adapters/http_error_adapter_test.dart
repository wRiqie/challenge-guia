import 'dart:io';

import 'package:challenge_guia/app/data/adapters/http_error_adapter.dart';
import 'package:challenge_guia/app/data/models/error_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[HTTP Error Adapter] ->', () {
    test('Deve devolver a mensagem de erro em formato de ErrorModel', () {
      var errorMock = HttpException('Ocorreu um erro');
      var treatedError = HttpErrorAdapter.convertToErrorModel(errorMock);

      expect(treatedError, isA<ErrorModel>());
      expect(treatedError.message, 'Ocorreu um erro');
    });
  });
}
