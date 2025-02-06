import 'dart:convert';
import 'dart:io';

import 'package:challenge_guia/app/core/values/constants.dart';
import 'package:challenge_guia/app/data/services/http/http_service_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class HttpClientMock extends Mock implements http.Client {}

void main() {
  late HttpServiceImp httpService;
  late HttpClientMock mockHttpClient;

  final uri = Uri.parse('${Constants.baseUrl}/test');

  setUp(() {
    mockHttpClient = HttpClientMock();
    httpService = HttpServiceImp(client: mockHttpClient);
  });

  test('Deve retornar Response ao chamar GET com sucesso', () async {
    final fakeResponse = http.Response(jsonEncode({'message': 'Success'}), 200);

    when(() => mockHttpClient.get(uri, headers: any(named: 'headers')))
        .thenAnswer((_) async => fakeResponse);

    final response = await httpService.get('/test');

    expect(response, isA<http.Response>());
    expect(response.statusCode, 200);
    expect(jsonDecode(response.body)['message'], 'Success');
  });

  test('Deve lançar um erro quando GET falhar', () async {
    when(() => mockHttpClient.get(uri, headers: any(named: 'headers')))
        .thenThrow(HttpException('Erro na requisição'));

    expect(() => httpService.get('/test'), throwsA(isA<HttpException>()));
  });

  test('Deve lançar HttpException e converter para erro adequado', () async {
    when(() => mockHttpClient.get(uri, headers: any(named: 'headers')))
        .thenThrow(HttpException('Erro simulado'));

    expect(
      () => httpService.get('/test'),
      throwsA(isA<HttpException>()),
    );
  });
}
