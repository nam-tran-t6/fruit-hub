import 'dart:async';
import 'dart:io';

import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/services/base_service/base_api_exception.dart';
import 'package:flutter_fruit_hub/src/services/logger_service.dart';
import 'package:http/http.dart' as http;

abstract class BaseApiMethodRequest {
  Future<String> executeGetRequest();
}

abstract class BaseApiService implements BaseApiMethodRequest {
  final String _baseUrl = 'oxcnfge59k.execute-api.us-west-2.amazonaws.com';
  http.Client httpClient = http.Client();

  Future<String> executeGetRequest() async {
    var responseJson;
    try {
      final uri = Uri.https(_baseUrl, getEndpoint(), getParams());
      final response = await httpClient.get(uri).timeout(Duration(seconds: 5));
      LoggerService.instance.log(LogLevel.INFO, 'Sending HTTP Request to $uri');
      responseJson = _returnResponse(response);
    } on TimeoutException {
      LoggerService.instance.logError(TimeoutException(Strings.error_request_timed_out), StackTrace.current);
      throw TimeoutException(Strings.error_request_timed_out);
    } on SocketException {
      LoggerService.instance.logError(NoInternetException(Strings.error_no_internet_message), StackTrace.current);
      throw NoInternetException(Strings.error_no_internet_message);
    }
    return responseJson;
  }

  String _returnResponse(http.Response response) {
    RequestException exception;
    String message = 'Response status code: ${response.statusCode}\nResponse body:${response.body}';

    if (response.statusCode == 200) {
      LoggerService.instance.log(LogLevel.INFO, message);
      return response.body;
    } else if (response.statusCode == 400) {
      exception = BadRequestException(Strings.error_invalid_request);
    } else if (response.statusCode == 403) {
      exception = UnauthorizedException(Strings.error_unauthorized);
    } else if (response.statusCode == 500) {
      exception = InternalServerException(Strings.error_internal_server);
    } else {
      exception = FetchDataException(Strings.error_while_fetch_data);
    }
    LoggerService.instance.logError(exception, StackTrace.current, message: message);
    throw exception;
  }

  String getEndpoint();

  Map<String, dynamic>? getParams();
}
