import 'dart:convert';

import 'package:flutter_fruit_hub/src/models/authentication_model.dart';
import 'package:flutter_fruit_hub/src/services/auth_api_service.dart';

class AuthRepository {
  Future<AuthResponseModel> authLogin(AuthRequestModel authRequestModel) async {
    String responseStr = await AuthApiService().authLogin(authRequestModel);
    Map<String, dynamic> data = json.decode(responseStr);
    return AuthResponseModel.fromJson(data);
  }
}
