import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:providerexample/enums/currency.dart';

class CurrencyService {
  final String _apiKey = const String.fromEnvironment("CURRENCYAPI_API_KEY");

  Future<double> getConversionRate(
      Currency fromCurrency, Currency toCurrency) async {
    final String url =
        "https://currencyapi.net/api/v1/rates?key=$_apiKey&base=${fromCurrency.name}&output=JSON";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      return jsonResponse["rates"][toCurrency.name];
    }

    return 0;
  }
}
