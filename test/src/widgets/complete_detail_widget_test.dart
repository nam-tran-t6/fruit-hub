import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/complete_detail/complete_detail_cubit.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/widgets/complete_details_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCompleteDetailCubit extends MockCubit<CompleteDetailState>
    implements CompleteDetailCubit {}

class FakeCompleteDetailState extends Fake implements CompleteDetailState {}

void main() {
  late CompleteDetailCubit mockCompleteDetailCubit;
  setUpAll(() {
    registerFallbackValue<FakeCompleteDetailState>(FakeCompleteDetailState());
  });
  setUp(() {
    mockCompleteDetailCubit = MockCompleteDetailCubit();
    when(() => mockCompleteDetailCubit.state)
        .thenReturn(CompleteDetailInitial());
  });
  tearDown(() {
    mockCompleteDetailCubit.close();
  });
  testWidgets(
    'should find Please fill in this field message when the text file is empty',
    (WidgetTester tester) async {
      when(() => mockCompleteDetailCubit.state).thenReturn(
          CompleteDetailErrorInput(
              [Strings.error_blank_text, Strings.error_blank_text]));
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => mockCompleteDetailCubit,
          child: MaterialApp(
            home: Scaffold(
              bottomSheet: CompleteDetailsWidget(),
            ),
          ),
        ),
      );
      final addButton = find.text(Strings.pay_on_delivery);
      await tester.tap(addButton);
      await tester.pumpAndSettle();
      expect(find.text(Strings.error_blank_text), findsNWidgets(2));
    },
  );
  testWidgets(
    'should find one error empty field',
    (WidgetTester tester) async {
      when(() => mockCompleteDetailCubit.state).thenReturn(
          CompleteDetailErrorInput(
              ['', Strings.error_blank_text]));
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => mockCompleteDetailCubit,
          child: MaterialApp(
            home: Scaffold(
              bottomSheet: CompleteDetailsWidget(),
            ),
          ),
        ),
      );
      final addressField = find.byKey(ValueKey('address_field'));
      await tester.enterText(
          addressField, 'khu 2 hoang thuong thanh 3 phu tho');
      final addButton = find.text(Strings.pay_on_delivery);
      await tester.tap(addButton);
      await tester.pumpAndSettle();
      expect(find.text(Strings.error_blank_text), findsOneWidget);
    },
  );
  testWidgets(
    'should find one error empty field and one invalid input',
        (WidgetTester tester) async {
      when(() => mockCompleteDetailCubit.state).thenReturn(
          CompleteDetailErrorInput(
              [Strings.error_blank_text, Strings.error_invalidate_input]));
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => mockCompleteDetailCubit,
          child: MaterialApp(
            home: Scaffold(
              bottomSheet: CompleteDetailsWidget(),
            ),
          ),
        ),
      );
      final addressField = find.byKey(ValueKey('address_field'));
      final phoneField = find.byKey(ValueKey('phone_field'));
      await tester.enterText(
          addressField, '');
      await tester.enterText(phoneField, '0e34571374923e');
      final addButton = find.text(Strings.pay_on_delivery);
      await tester.tap(addButton);
      await tester.pumpAndSettle();
      expect(find.text(Strings.error_invalidate_input), findsOneWidget);
      expect(find.text(Strings.error_blank_text), findsOneWidget);
    },
  );
}
