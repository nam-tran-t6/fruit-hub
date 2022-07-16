import 'package:bloc/bloc.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/models/authentication_model.dart';
import 'package:flutter_fruit_hub/src/repositories/auth_repository.dart';
import 'package:flutter_fruit_hub/src/services/remote_config_service.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());
  String _inputName = '';

  var authRepository = AuthRepository();

  void setInputName(String inputName) {
    this._inputName = inputName;
  }

  void sendReqLogin() async {
    if (checkInputField()) {
      emit(AuthenticationLoading());
      final authRequestModel = AuthRequestModel(
        name: this._inputName,
      );
      var authResponse = await authRepository.authLogin(authRequestModel);
      checkValidation(authResponse);
    }
  }

  bool checkInputField() {
    if (this._inputName.contains(RegExp(r'[0-9]'))) {
      emit(AuthenticationErrorInput(Strings.name_does_not_contains_number));
      return false;
    } else if (this._inputName.isEmpty) {
      emit(AuthenticationErrorInput(Strings.name_cant_be_empty));
      return false;
    }
    return true;
  }

  void checkValidation(AuthResponseModel authResponse) {
    if (authResponse.isValid) {
      emit(AuthenticationSuccess(username: _inputName));
    } else {
      emit(AuthenticationError(authResponse.message));
    }
  }

  void getFirebaseConfig() async {
    var config = AppRemoteConfigService();
    await config.fetchAndActive();
    emit(
      AuthenticationStateNewConfig(config.authFruitBasketImageUrl,
          config.welcomeFruitShadowImageUrl, config.authFruitDropImageUrl),
    );
  }
}
