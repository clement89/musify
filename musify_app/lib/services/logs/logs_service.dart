abstract class LogService {
  /// Logs an info message
  void logInfo(String message, {String? tag});

  /// Logs a warning message
  void logWarning(String message, {String? tag});

  /// Logs an error message with optional exception details
  void logError(String message,
      {String? tag, dynamic error, StackTrace? stackTrace});

  /// Logs debug messages (useful for development)
  void logDebug(String message, {String? tag});
}
