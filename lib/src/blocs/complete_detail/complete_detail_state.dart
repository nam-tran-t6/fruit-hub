part of 'complete_detail_cubit.dart';

@immutable
abstract class CompleteDetailState {}

class CompleteDetailInitial extends CompleteDetailState {}

class CompleteDetailErrorInput extends CompleteDetailState {
  final List<String> _errorText;

  CompleteDetailErrorInput(this._errorText);

  List<String> get getErrorText => this._errorText;
}

class ValidInformationInputState extends CompleteDetailState {}

class ShouldShowInputCardState extends CompleteDetailState {}
