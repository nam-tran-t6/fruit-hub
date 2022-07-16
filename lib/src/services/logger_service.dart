import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_fruit_hub/src/helpers/extension/datetime_extension.dart';

enum LogLevel { DEBUG, INFO, WARNING, ERROR }

class LoggerService {
  List<OutputLogger>? _loggedData;
  static final LoggerService _singleton = LoggerService._internal();
  LoggerService._internal();
  static final LoggerService instance = LoggerService();

  factory LoggerService({List<OutputLogger>? logOutputs}) {
    _singleton._loggedData = logOutputs ?? _singleton._loggedData;
    return _singleton;
  }

  Future<void> log(LogLevel level, String message, {StackTrace? stackTrace, bool includeStackTrace = false}) async {
    String timeStamp = DateTime.now().toDateFormat();
    stackTrace = stackTrace ?? StackTrace.current;
    String loggedMessage = '$timeStamp\t$level\t$message';
    loggedMessage = includeStackTrace ? '$loggedMessage\n\t${stackTrace.toString()}' : loggedMessage;
    _loggedData!.forEach((logOutput) {
      logOutput.logData(loggedMessage);
    });
  }

  Future<void> logError(dynamic exception, StackTrace stackTrace, {BuildContext? context, String message = ''}) async {
    log(LogLevel.ERROR, '${exception.toString()}\n$message', stackTrace: stackTrace, includeStackTrace: true);

    _loggedData!.forEach((logOutput) {
      logOutput.logError(exception, stackTrace, context: context, message: message);
    });
  }
}

abstract class OutputLogger {
  void logData(String message);

  void logError(dynamic exception, StackTrace trace, {BuildContext? context, String? message});
}

class ConsoleLogger extends OutputLogger {
  @override
  void logData(String message) {
    print(message);
  }

  @override
  void logError(exception, StackTrace trace, {BuildContext? context, String? message}) {
    print(exception.toString());
  }
}

class FirebaseLogger extends OutputLogger {
  final FirebaseCrashlytics instance;

  FirebaseLogger(this.instance);

  @override
  void logData(String message) {
    instance.log(message);
  }

  @override
  void logError(exception, StackTrace trace, {BuildContext? context, String? message}) {
    instance.recordError(exception, trace);
  }
}

