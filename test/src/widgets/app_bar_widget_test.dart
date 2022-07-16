import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/widgets/app_bar_widget.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  testWidgets("Test Appbar Widget", (WidgetTester tester) async {
    bool testGoBackTapped = false;

    await tester.pumpWidget(MaterialApp(
        home: AppBarWidget(
            title: "Fruits",
            percentageHeight: 0.1,
            actionBackPress: () {
              testGoBackTapped = !testGoBackTapped;
            },)));

    expect(find.text('Fruits'), findsOneWidget);

    expect(find.text('fruit'), findsNothing);

    var inkWell = find.byType(InkWell);
    expect(inkWell, findsOneWidget);
    await tester.tap(inkWell, pointer: 1);
    await tester.pump(const Duration(seconds: 1));
    expect(testGoBackTapped, equals(true));
  });
}