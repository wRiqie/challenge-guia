import 'package:challenge_guia/app/core/helpers/app_helpers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    '[AppHelpers] -> ',
    () {
      test(
        'Deve devolver a formatação de moeda pt_BR por padrão',
        () {
          var value = 10;
          var formattedValue = AppHelpers.formatCurrency(value);

          expect(formattedValue, equals('R\$ 10,00'));
        },
      );

      test(
        'Deve devolver a formatação de moeda en_US',
        () {
          var value = 10;
          var formattedValue =
              AppHelpers.formatCurrency(value, currencyLocale: 'en_US');

          expect(formattedValue, equals('\$10.00'));
        },
      );

      test(
        'Deve devolver a vazio se o valor for nulo',
        () {
          var formattedValue = AppHelpers.formatCurrency(null);

          expect(formattedValue, equals(''));
        },
      );
    },
  );
}
