import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/screens/order_completed_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test Oder Completed', () {
    late Widget orderCompleted;

    setUp(() {
      orderCompleted = MaterialApp(home: OrderCompletedScreen());
    });

    testWidgets('test widget', (WidgetTester tester) async {
      await tester.pumpWidget(orderCompleted);

      expect(find.text(Strings.your_order_taken_attended_to), findsOneWidget);

      expect(find.text(Strings.congratulations), findsOneWidget);

      expect(find.text(Strings.track_order), findsOneWidget);

      expect(find.text(Strings.continue_shopping), findsOneWidget);

    });

  });
}

