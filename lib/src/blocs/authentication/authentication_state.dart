part of 'authentication_cubit.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  final String _errorMessage;

  AuthenticationError(
    this._errorMessage,
  ) : super();

  String get getErrorMessage => this._errorMessage;
}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final String username;

  AuthenticationSuccess({required this.username});
}

class AuthenticationErrorInput extends AuthenticationState {
  final String _errorMessage;

  AuthenticationErrorInput(
    this._errorMessage,
  ) : super();

  String get getErrorMessage => this._errorMessage;
}

class AuthenticationStateNewConfig extends AuthenticationState {
  final String fruitBasketImageUrl;
  final String fruitShadowImageUrl;
  final String fruitDropImageUrl;

  AuthenticationStateNewConfig(
    this.fruitBasketImageUrl,
    this.fruitShadowImageUrl,
    this.fruitDropImageUrl,
  ) : super();
}
