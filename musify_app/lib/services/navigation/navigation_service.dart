import 'package:flutter/material.dart';

abstract class NavigationService {
  GlobalKey<NavigatorState>? get navigatorKey;
  GlobalKey<ScaffoldMessengerState>? get snackbarKey;

  void back<T extends Object?>([T? result]);

  Future<T?>? navigateToNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  });

  Future<T?>? navigateToAndRemoveUntil<T extends Object?>(
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  });

  Future<T?>?
      navigateToAndReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  });
}
