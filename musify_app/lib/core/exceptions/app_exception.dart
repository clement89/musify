import 'package:flutter/material.dart';
import 'package:musify_app/core/extentions/buildcontect_extention.dart';

class AppException implements Exception {
  final String code;

  AppException({required this.code});

  @override
  String toString() => '[$code]';

  /// Core errors
  static AppException networkError() => AppException(code: "NETWORK_ERROR");
  static AppException timeout() => AppException(code: "TIMEOUT");
  static AppException unexpected() => AppException(code: "UNEXPECTED_ERROR");
  static AppException storageError() => AppException(code: "STORAGE_ERROR");
  static AppException notFound() => AppException(code: "NOT_FOUND_ERROR");

  static String getCoreErrorMessage(BuildContext context, String code) {
    switch (code) {
      case "NETWORK_ERROR":
        return context.loc.errorNetwork;
      case "TIMEOUT":
        return context.loc.errorTimeout;
      case "UNEXPECTED_ERROR":
        return context.loc.errorUnexpected;
      case "STORAGE_ERROR":
        return context.loc.errorStorage;
      case "NOT_FOUND_ERROR":
        return context.loc.errorNotFound;
      default:
        return context.loc.errorGeneric;
    }
  }
}
