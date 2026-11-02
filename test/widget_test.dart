
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freshly_app/main.dart';

void main() {
  testWidgets('Freshly app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const FreshlyApp());

    expect(find.text('Your Storage'), findsOneWidget);
    expect(find.text('Shelf'), findsWidgets);
    expect(find.text('Fridge'), findsWidgets);
  });
}
