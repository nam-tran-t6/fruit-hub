import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/input_card_detail/input_card_detail_cubit.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_button_style.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_text_styles.dart';
import 'package:flutter_fruit_hub/src/widgets/input_card_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test Input Card', () {
    late Widget inputCardWidget;

    setUp(() {
      inputCardWidget = MaterialApp(
        home: Scaffold(
          bottomSheet: BlocProvider(
            create: (context) => InputCardDetailCubit(),
            child: InputCardWidget(),
          ),
        ),
      );
    });

    testWidgets('Test widget', (WidgetTester tester) async {
      await tester.pumpWidget(inputCardWidget);

      expect(find.text(Strings.complete_order), findsOneWidget);

      expect(find.text(Strings.card_holders_name), findsOneWidget);

      expect(find.text(Strings.card_number), findsOneWidget);

      expect(find.text(Strings.date), findsOneWidget);

      expect(find.text(Strings.ccv), findsOneWidget);

      expect(find.text(Strings.adolphus_chris), findsOneWidget);

      expect(find.text(Strings.card_number_detail), findsOneWidget);

      expect(find.text(Strings.ccv_detail), findsOneWidget);

      expect(find.text(Strings.date_detail), findsOneWidget);
    });

    testWidgets('Find error message when all text field is empty',
        (WidgetTester tester) async {
      final completeOderButton = find.text(Strings.complete_order);

      await tester.pumpWidget(inputCardWidget);

      await tester.tap(completeOderButton);

      await tester.pump();

      expect(find.text(Strings.error_blank_text), findsWidgets);
    });

    testWidgets('Find error message when CCV is empty', (WidgetTester tester) async {
      final cardHoldersNameField = find.byKey(ValueKey('card_holders_name'));

      final cardNumberField = find.byKey(ValueKey('card_number_detail'));

      final dateDetailField = find.byKey(ValueKey('date_detail'));

      final completeOderButton = find.text(Strings.complete_order);

      await tester.pumpWidget(inputCardWidget);

      await tester.enterText(cardHoldersNameField, 'Nguyen Trinh Huy');

      await tester.enterText(cardNumberField, '1234567890121314');

      await tester.enterText(dateDetailField, '10/10');

      await tester.tap(completeOderButton);

      await tester.pump();

      expect(find.text(Strings.error_blank_text), findsOneWidget);
    });

    testWidgets('Test text style', (WidgetTester tester) async {
      final cardHoldersName = find.text(Strings.card_holders_name);

      await tester.pumpWidget(inputCardWidget);

      await tester.pump();

      Text text = tester.firstWidget(cardHoldersName);

      expect(text.style, AppTextStyles.kBoldPortGore20);
    });

    testWidgets('Test ElevatedButton style', (WidgetTester tester) async {
      final completeOrderButton = find.byType(ElevatedButton);

      await tester.pumpWidget(inputCardWidget);

      await tester.pump();

      ElevatedButton elevatedButton = tester.firstWidget(completeOrderButton);

      expect(elevatedButton.style, AppButtonStyles.kWhiteBorder10);
    });
  });
}
