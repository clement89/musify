import 'package:flutter/foundation.dart';
import 'package:musify_app/services/logs/logs_service.dart';

class LogServiceImpl implements LogService {
  // Private constructor for Singleton
  LogServiceImpl._privateConstructor();

  // Singleton instance
  static final LogServiceImpl _instance = LogServiceImpl._privateConstructor();

  // Factory constructor to return the same instance
  factory LogServiceImpl() {
    return _instance;
  }

  @override
  void logInfo(String message, {String? tag}) {
    _log("INFO", message, tag);
  }

  @override
  void logWarning(String message, {String? tag}) {
    _log("WARNING", message, tag);
  }

  @override
  void logError(String message,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    _log("ERROR", "$message ${error != null ? " | Error: $error" : ""}", tag);
    if (stackTrace != null) {
      debugPrint("StackTrace: $stackTrace");
    }
  }

  @override
  void logDebug(String message, {String? tag}) {
    if (kDebugMode) {
      _log("DEBUG", message, tag);
    }
  }

  void _log(String level, String message, String? tag) {
    debugPrint("[${tag ?? 'APP'}] $level: $message");
  }
}
