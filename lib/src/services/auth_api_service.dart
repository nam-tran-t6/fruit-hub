import 'dart:convert';
import 'dart:io';

import 'package:flutter_fruit_hub/src/models/authentication_model.dart';

import 'logger_service.dart';

const _root =
    'https://oxcnfge59k.execute-api.us-west-2.amazonaws.com/dev/fruit-hub/users';

class AuthApiService {
  Future<String> authLogin(AuthRequestModel authRequestModel) async {
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(_root));
    LoggerService.instance.log(LogLevel.INFO, 'Sending HTTP Request to ${Uri.parse(_root)}');
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(authRequestModel.toJson())));
    HttpClientResponse response = await request.close();
    if (response.statusCode == 200 || response.statusCode == 400) {
      String reply = await response.transform(utf8.decoder).join();
      LoggerService.instance.log(LogLevel.INFO, 'Response status code: ${response.statusCode}\nResponse body:$reply}');
      httpClient.close();
      return reply;
    }
    throw Exception('Failed to load Data');
  }
}
