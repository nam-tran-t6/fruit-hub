import 'package:bloc/bloc.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/services/logger_service.dart';
import 'package:meta/meta.dart';

part 'complete_detail_state.dart';

class CompleteDetailCubit extends Cubit<CompleteDetailState> {
  CompleteDetailCubit() : super(CompleteDetailInitial());
  String _address = '';
  String _phoneNumber = '';

  void setAddress(String address) {
    this._address = address;
  }

  void setPhoneNumber(String phone) {
    this._phoneNumber = phone;
  }

  void submit() {
    if (_isValidAddressAndPhoneNumber()) emit(ValidInformationInputState());
  }

  void payWithCard() {
    if (_isValidAddressAndPhoneNumber()) {
      LoggerService.instance.log(LogLevel.INFO, 'isValidUser: ${_isValidAddressAndPhoneNumber()}\nAddress: $_address\nPhone Number: $_phoneNumber');
      emit(ShouldShowInputCardState());
    }
  }

  bool _isEmptyAddressField() {
    return _address.isEmpty;
  }

  bool _isEmptyPhoneNumberField() {
    return _phoneNumber.isEmpty;
  }

  bool _isValidAddressAndPhoneNumber() {
    var _isValid = true;
    var addressMessage = '';
    var phoneNoMessage = '';
    if (_isEmptyAddressField()) {
      addressMessage = Strings.error_blank_text;
      _isValid = false;
    }
    if (_isEmptyPhoneNumberField()) {
      phoneNoMessage = Strings.error_blank_text;
      _isValid = false;
    } else {
      if (!_isValidPhoneNumber()) {
        phoneNoMessage = Strings.error_phone_number;
        _isValid = false;
      }
    }
    if (!_isValid) {
      emit(CompleteDetailErrorInput([addressMessage, phoneNoMessage]));
    }
    return _isValid;
  }

  bool _isValidPhoneNumber() {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(_phoneNumber)) {
      return false;
    }
    return true;
  }
}
