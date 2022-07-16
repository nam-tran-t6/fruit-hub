import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_colors.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/app_icons.dart';
import 'package:flutter_fruit_hub/src/widgets/round_icon_button.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Test round icon button widget', () {
    testWidgets("Test round icon button enable", (WidgetTester tester) async {
      bool roundButtonEvent = false;

      await tester.pumpWidget(MaterialApp(
          home: RoundIconButton(
        icon: AppIcons.minus,
        fillColor: AppColors.serenade,
        size: 32,
        borderColor: AppColors.serenade,
        iconColor: AppColors.texas_rose,
        onPressed: () {
          roundButtonEvent = !roundButtonEvent;
        },
      )));

      var gestureDetector = find.byType(InkWell);
      expect(gestureDetector, findsOneWidget);
      await tester.tap(gestureDetector, pointer: 1);
      expect(roundButtonEvent, equals(true));

      var icon = find.byType(Icon);
      expect(icon, findsOneWidget);
      var iconColorsDisable = ((tester.firstWidget(icon)) as Icon).color;
      expect(iconColorsDisable, AppColors.texas_rose);
    });

    testWidgets("Test round icon button disable", (WidgetTester tester) async {
      bool roundButtonEvent = false;

      await tester.pumpWidget(MaterialApp(
          home: RoundIconButton(
        icon: AppIcons.minus,
        fillColor: AppColors.serenade,
        size: 32,
        borderColor: AppColors.serenade,
        iconColor: AppColors.texas_rose,
        isDisable: true,
        onPressed: () {
          roundButtonEvent = !roundButtonEvent;
        },
      )));

      var inkWell = find.byType(InkWell);
      expect(inkWell, findsOneWidget);
      await tester.tap(inkWell, pointer: 1);
      expect(roundButtonEvent, equals(false));

      var icon = find.byType(Icon);
      expect(icon, findsOneWidget);
      var iconColorsDisable = ((tester.firstWidget(icon)) as Icon).color;
      expect(iconColorsDisable, AppColors.texas_rose.withOpacity(0.3));
    });
  });
}
