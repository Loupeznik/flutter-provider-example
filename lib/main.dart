import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerexample/enums/currency.dart';
import 'package:providerexample/providers/currency_conversion_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CurrencyConversionProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Currency Converter example with Provider'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _fromValue = Currency.values.first;
  var _toValue = Currency.values.first;

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownMenu<Currency>(
                    label: const Text('From'),
                    initialSelection: _fromValue,
                    onSelected: (Currency? value) {
                      setState(() {
                        _fromValue = value!;
                      });
                    },
                    dropdownMenuEntries: Currency.values
                        .map<DropdownMenuEntry<Currency>>((Currency value) {
                      return DropdownMenuEntry<Currency>(
                        value: value,
                        label: value.name,
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownMenu<Currency>(
                    label: const Text('To'),
                    key: const ValueKey('toCurrencyDropdown'),
                    initialSelection: _toValue,
                    onSelected: (Currency? value) {
                      setState(() {
                        _toValue = value!;
                      });
                    },
                    dropdownMenuEntries: Currency.values
                        .map<DropdownMenuEntry<Currency>>((Currency value) {
                      return DropdownMenuEntry<Currency>(
                        value: value,
                        label: value.name,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Card(
              color: !isLoading ? Colors.blueAccent : null,
              margin: const EdgeInsets.all(12.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: !isLoading
                    ? Text(
                        "1 ${context.watch<CurrencyConversionProvider>().conversion.fromCurrency.name} = ${context.watch<CurrencyConversionProvider>().conversionRate.toString()} ${context.watch<CurrencyConversionProvider>().conversion.toCurrency.name}",
                        style: const TextStyle(fontSize: 24),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await context
                    .read<CurrencyConversionProvider>()
                    .convert(_fromValue, _toValue)
                    .then((_) => setState(() {
                          isLoading = false;
                        }));
              },
              label: const Text("Get Conversion Rate"),
              icon: const Icon(Icons.currency_exchange),
            )
          ],
        ),
      ),
    );
  }
}
