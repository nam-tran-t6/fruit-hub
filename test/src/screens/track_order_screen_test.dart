import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/screens/track_order_screen.dart';
import 'package:flutter_test/flutter_test.dart';

main() {

  testWidgets("Test track order screen", (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(
        home: TrackOrderScreen(
        )));
    await tester.pumpAndSettle(const Duration(seconds: 42));

    expect(find.text(Strings.order_taken), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    expect(find.text(Strings.order_is_being_prepared), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));

    expect(find.text(Strings.order_is_being_delivered), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));

    expect(find.text(Strings.order_received), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));

    var inkWell = find.byType(InkWell);
    expect(inkWell, findsOneWidget);
    await tester.tap(inkWell, pointer: 1);
    await tester.pump(const Duration(seconds: 1));
  });

}