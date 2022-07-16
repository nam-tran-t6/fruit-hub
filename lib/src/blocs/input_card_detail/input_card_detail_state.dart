part of 'input_card_detail_cubit.dart';

@immutable
abstract class InputCardState {}

class InputCardInitial extends InputCardState {}

class InputCardSubmitSuccess extends InputCardState {}

class InputCardError extends InputCardState {
  final List<String> _errorText;

  InputCardError(this._errorText);

  List<String> get getErrorText => this._errorText;
}
