import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:providerexample/main.dart';

void main() {
  testWidgets('Fetch currency rates test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Get Conversion Rate'), findsOneWidget);
    expect(find.byIcon(Icons.currency_exchange), findsOneWidget);
    expect(find.byIcon(Icons.search), findsNothing);

    final dropdown = find.byKey(const ValueKey('toCurrencyDropdown'));
    await tester.tap(dropdown);
    await tester.pumpAndSettle();

    final dropdownItem = find.text('GBP').last;

    await tester.tap(dropdownItem);
    await tester.pumpAndSettle();

    expect(find.text('GBP'), findsOneWidget);

    final convertButton = find.byIcon(Icons.currency_exchange);
    await tester.tap(convertButton);

    await tester.pumpAndSettle();

    expect(
        find.textContaining(RegExp(r'1 USD = \d+\.\d+ GBP')), findsOneWidget);
  });
}
