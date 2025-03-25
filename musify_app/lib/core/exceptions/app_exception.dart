import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:musify_app/core/extentions/buildcontect_extention.dart';

class AppException extends Equatable implements Exception {
  final String code;

  const AppException({required this.code});

  @override
  List<Object> get props => [code];

  @override
  String toString() => '[$code]';

  /// Core errors
  static const AppException networkError = AppException(code: "NETWORK_ERROR");
  static const AppException timeout = AppException(code: "TIMEOUT");
  static const AppException unexpected = AppException(code: "UNEXPECTED_ERROR");
  static const AppException storageError = AppException(code: "STORAGE_ERROR");
  static const AppException notFound = AppException(code: "NOT_FOUND_ERROR");

  static String getCoreErrorMessage(BuildContext context, String? code) {
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
