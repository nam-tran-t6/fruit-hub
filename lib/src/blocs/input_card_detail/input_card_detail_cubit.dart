import 'package:bloc/bloc.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:meta/meta.dart';

part 'input_card_detail_state.dart';

class InputCardDetailCubit extends Cubit<InputCardState> {
  InputCardDetailCubit() : super(InputCardInitial());
  String _card_holder_name = '';
  String _card_number = '';
  String _card_date = '';
  String _card_ccv = '';

  void submit() {
    if (_isValidAllCardDetail()) emit(InputCardSubmitSuccess());
  }

  bool _isValidAllCardDetail() {
    var _isValid = true;
    var blackCardNameErrorMess = '';
    var blackCardPhoneErrorMess = '';
    var blackCardDateErrorMess = '';
    var blackCardCCVErrorMess = '';

    if (_isEmptyCardHolder()) {
      blackCardNameErrorMess = Strings.error_blank_text;
      _isValid = false;
    }
    if (_isEmptyCardNumber()) {
      blackCardPhoneErrorMess = Strings.error_blank_text;
      _isValid = false;
    }
    if (_isEmptyCardDate()) {
      blackCardDateErrorMess = Strings.error_blank_text;
      _isValid = false;
    }
    if (_isEmptyCardCCV()) {
      blackCardCCVErrorMess = Strings.error_blank_text;
      _isValid = false;
    }
    if (!_isValid) {
      emit(InputCardError([
        blackCardNameErrorMess,
        blackCardPhoneErrorMess,
        blackCardDateErrorMess,
        blackCardCCVErrorMess,
      ]));
    }
    return _isValid;
  }

  bool _isEmptyCardHolder() {
    return _card_holder_name.isEmpty;
  }

  bool _isEmptyCardNumber() {
    return _card_number.isEmpty;
  }

  bool _isEmptyCardDate() {
    return _card_date.isEmpty;
  }

  bool _isEmptyCardCCV() {
    return _card_ccv.isEmpty;
  }

  set setCardCcv(String value) {
    _card_ccv = value;
  }

  set setCardDate(String value) {
    _card_date = value;
  }

  set setCardNumber(String value) {
    _card_number = value;
  }

  set setCardHolderName(String value) {
    _card_holder_name = value;
  }
}
