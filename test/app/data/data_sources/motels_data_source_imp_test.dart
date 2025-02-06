import 'dart:convert';

import 'package:challenge_guia/app/data/data_sources/motels_data_source.dart';
import 'package:challenge_guia/app/data/data_sources/motels_data_source_imp.dart';
import 'package:challenge_guia/app/data/models/motel_model.dart';
import 'package:challenge_guia/app/data/models/paginable_model.dart';
import 'package:challenge_guia/app/data/services/http/http_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class HttpServiceMock extends Mock implements HttpService {}

void main() {
  late HttpService httpService;
  late MotelsDataSource motelsDataSource;
  final jsonMock =
      '{"sucesso":true,"data":{"pagina":1,"qtdPorPagina":10,"totalSuites":0,"totalMoteis":1,"raio":0,"maxPaginas":1,"moteis":[{"fantasia":"Motel Le Nid","logo":"https://cdn.guiademoteis.com.br/imagens/logotipos/3148-le-nid.gif","bairro":"ChÃ¡cara Flora - SÃ£o Paulo","distancia":28.27,"qtdFavoritos":0,"suites":[{"nome":"SuÃ­te Marselha s/ garagem privativa","qtd":1,"exibirQtdDisponiveis":true,"fotos":["https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_1.jpg","https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_2.jpg","https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_3.jpg","https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_4.jpg"],"itens":[{"nome":"ducha dupla"},{"nome":"TV a cabo"},{"nome":"TV LED 32'
      '"},{"nome":"iluminaÃ§Ã£o por leds"},{"nome":"garagem coletiva"},{"nome":"som AM/FM"},{"nome":"3 canais erÃ³ticos"},{"nome":"bluetooth"},{"nome":"espelho no teto"},{"nome":"acesso Ã  suÃ­te via escadas"},{"nome":"frigobar"},{"nome":"ar-condicionado split"},{"nome":"WI-FI"},{"nome":"secador de cabelo"}],"categoriaItens":[{"nome":"Frigobar","icone":"https://cdn.guiademoteis.com.br/Images/itens-suites/frigobar-04-09-2018-12-14.png"},{"nome":"Ar-Condicionado","icone":"https://cdn.guiademoteis.com.br/Images/itens-suites/arcondicionado-04-09-2018-12-13.png"},{"nome":"Internet Wi-Fi","icone":"https://cdn.guiademoteis.com.br/Images/itens-suites/internet-wifi-22-08-2018-11-42.png"},{"nome":"Secador de Cabelo","icone":"https://cdn.guiademoteis.com.br/Images/itens-suites/secador-de-cabelo-04-09-2018-12-14.png"}],"periodos":[{"tempoFormatado":"3 horas","tempo":"3","valor":88,"valorTotal":88,"temCortesia":false,"desconto":null},{"tempoFormatado":"6 horas","tempo":"6","valor":101,"valorTotal":101,"temCortesia":false,"desconto":null},{"tempoFormatado":"12 horas","tempo":"12","valor":129.58,"valorTotal":81.58,"temCortesia":false,"desconto":{"desconto":48}}]}],"qtdAvaliacoes":2159,"media":4.6}]},"mensagem":[]}';

  setUp(() {
    httpService = HttpServiceMock();
    motelsDataSource = MotelsDataSourceImp(httpService);
  });

  group('[MotelsDataSourceImp] -> ', () {
    test('Deve devolver um PaginableModel com sucesso', () async {
      final fakeHttpResponse = FakeHttpResponse(utf8.encode(jsonMock));
      when(() => httpService.get(any()))
          .thenAnswer((_) async => fakeHttpResponse);

      var result = await motelsDataSource.getAllPaginated();

      expect(result, isA<PaginableModel<MotelModel>>());
      expect(result.length, 1);
      expect(result.items.first.name, "Motel Le Nid");
    });

    test('Deve lançar uma Exception quando a requisição falhar', () async {
      when(() => httpService.get(any()))
          .thenThrow(Exception('Erro de conexão'));

      expect(
          () => motelsDataSource.getAllPaginated(), throwsA(isA<Exception>()));
    });
  });
}

/// Classe fake para simular a resposta da requisição
class FakeHttpResponse {
  final List<int> bodyBytes;
  FakeHttpResponse(this.bodyBytes);
}
