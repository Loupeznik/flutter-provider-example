import 'package:flutter/material.dart';
import 'package:providerexample/enums/currency.dart';
import 'package:providerexample/models/currency_conversion.dart';
import 'package:providerexample/services/currency_service.dart';

class CurrencyConversionProvider with ChangeNotifier {
  Currency? _fromCurrency;
  Currency? _toCurrency;
  double? _rate;
  DateTime? _date;

  CurrencyService _currencyService = CurrencyService();

  void addConversion(
      {required Currency fromCurrency,
      required Currency toCurrency,
      required double rate,
      required DateTime date}) {
    _fromCurrency = fromCurrency;
    _toCurrency = toCurrency;
    _rate = rate;
    _date = date;

    notifyListeners();
  }

  Future convert(Currency fromCurrency, Currency toCurrency) async {
    final result =
        await _currencyService.getConversionRate(fromCurrency, toCurrency);

    addConversion(
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
        rate: result,
        date: DateTime.now());
  }

  CurrencyConversion get conversion => CurrencyConversion(
      fromCurrency: _fromCurrency ?? Currency.USD,
      toCurrency: _toCurrency ?? Currency.USD,
      rate: _rate ?? 0.0,
      date: _date ?? DateTime.now());

  double get conversionRate => _rate ?? 0.0;
}
