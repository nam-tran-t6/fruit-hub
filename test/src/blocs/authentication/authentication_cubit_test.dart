import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_fruit_hub/src/blocs/authentication/authentication_cubit.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/models/authentication_model.dart';
import 'package:flutter_fruit_hub/src/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class FakeAuthRequestModel extends Fake implements AuthRequestModel {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeAuthRequestModel());
  });

  group('AuthBloc', () {
    late MockAuthRepository repositoryMock;
    late AuthenticationCubit authenticationCubit;
    String testName = 'bo';
    AuthResponseModel responseSuccess =
        AuthResponseModel(isValid: true, message: 'Valid');
    AuthResponseModel responseFail =
        AuthResponseModel(isValid: false, message: 'Invalid');

    setUp(() {
      repositoryMock = MockAuthRepository();
      authenticationCubit = AuthenticationCubit();
      authenticationCubit.authRepository = repositoryMock;
    });

    tearDown(() {
      authenticationCubit.close();
    });

    blocTest<AuthenticationCubit, AuthenticationState>(
      'authenticate success - emit [AuthenticationLoading, AuthenticationSuccess]',
      build: () {
        when(() => repositoryMock.authLogin(any<FakeAuthRequestModel>()))
            .thenAnswer((_) async => responseSuccess);
        authenticationCubit.setInputName(testName);
        return authenticationCubit;
      },
      act: (cubit) async => authenticationCubit.sendReqLogin(),
      expect: () => [isA<AuthenticationLoading>(), isA<AuthenticationSuccess>()],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'authenticate fail - emit [AuthenticationLoading, AuthenticationError]',
      build: () {
        when(() => repositoryMock.authLogin(any<FakeAuthRequestModel>()))
            .thenAnswer((_) async => responseFail);
        authenticationCubit.setInputName(testName);
        return authenticationCubit;
      },
      act: (cubit) async => authenticationCubit.sendReqLogin(),
      expect: () => [isA<AuthenticationLoading>(), isA<AuthenticationError>()],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'Did not input username - emit [AuthenticationErrorInput]',
      build: () => authenticationCubit,
      act: (cubit) async => authenticationCubit.sendReqLogin(),
      expect: () => [
        isA<AuthenticationErrorInput>().having(
            (error) => error.getErrorMessage, '_errorMessage', Strings.name_cant_be_empty)
      ],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'input wrong user name contain numbers',
      build: () {
        authenticationCubit.setInputName('bo1');
        return authenticationCubit;
      },
      act: (cubit) async => authenticationCubit.checkInputField(),
      expect: () => [
        isA<AuthenticationErrorInput>().having((error) => error.getErrorMessage,
            '_errorMessage', Strings.name_does_not_contains_number)
      ],
    );
  });
}
