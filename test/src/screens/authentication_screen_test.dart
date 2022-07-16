import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/authentication/authentication_cubit.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/screens/authentication_screen.dart';
import 'package:flutter_fruit_hub/src/widgets/app_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationCubit extends MockCubit<AuthenticationState>
    implements AuthenticationCubit {}

class FakeAuthenticationState extends Fake implements AuthenticationState {}

void main() {
  late AuthenticationCubit mockAuthenticationCubit;
  setUpAll(() {
    registerFallbackValue<FakeAuthenticationState>(FakeAuthenticationState());
  });
  setUp(() {
    mockAuthenticationCubit = MockAuthenticationCubit();
    when(() => mockAuthenticationCubit.state)
        .thenReturn(AuthenticationInitial());
  });

  tearDown(() {
    mockAuthenticationCubit.close();
  });
  testWidgets(
    'should find error message when button click with input field is empty',
    (WidgetTester tester) async {
      when(() => mockAuthenticationCubit.state)
          .thenReturn(AuthenticationErrorInput(Strings.name_cant_be_empty));
      final addField = find.byType(TextField);
      final addButton = find.byType(AppButton);

      await tester.pumpWidget(
        BlocProvider(
          create: (context) => mockAuthenticationCubit,
          child: MaterialApp(
            home: AuthenticationScreen(),
          ),
        ),
      );
      await tester.enterText(addField, '');
      await tester.tap(addButton);
      await tester.pump();

      expect(find.text(Strings.name_cant_be_empty), findsOneWidget);
    },
  );

  testWidgets(
    'should find error message when button click with input contain numbers',
        (WidgetTester tester) async {
      when(() => mockAuthenticationCubit.state)
          .thenReturn(AuthenticationErrorInput(Strings.name_does_not_contains_number));
      final addField = find.byType(TextField);
      final addButton = find.byType(AppButton);

      await tester.pumpWidget(
        BlocProvider(
          create: (context) => mockAuthenticationCubit,
          child: MaterialApp(
            home: AuthenticationScreen(),
          ),
        ),
      );
      await tester.enterText(addField, 'de4443');
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      expect(find.text(Strings.name_does_not_contains_number), findsOneWidget);
    },
  );
}
