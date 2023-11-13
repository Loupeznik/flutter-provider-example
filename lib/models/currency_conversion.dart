import 'package:providerexample/enums/currency.dart';

class CurrencyConversion {
  final Currency fromCurrency;
  final Currency toCurrency;
  final double rate;
  final DateTime date;

  CurrencyConversion(
      {required this.fromCurrency,
      required this.toCurrency,
      required this.rate,
      required this.date});
}
