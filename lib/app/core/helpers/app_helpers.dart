import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppHelpers {
  /// Formata o [number] para moeda
  static String formatCurrency(num? number, {String? currencyLocale}) {
    if (number == null) return '';
    // Define uma expressão regular para encontrar espaços duros (&nbsp;).
    RegExp regexErrorSpace = RegExp(r'\u00a0');

    var formated = NumberFormat.simpleCurrency(
            locale: Locale(currencyLocale ?? 'pt_BR').toString())
        .format(number)
        .replaceAll(regexErrorSpace, ' ');
    return formated;
  }
}
