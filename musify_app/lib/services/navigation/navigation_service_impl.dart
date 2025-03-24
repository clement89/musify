import 'package:flutter/material.dart';
import 'package:musify_app/services/navigation/navigation_service.dart';

class NavigationServiceImpl implements NavigationService {
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> _snackbarKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  @override
  GlobalKey<ScaffoldMessengerState> get snackbarKey => _snackbarKey;

  @override
  void back<T extends Object?>([T? result]) {
    return navigatorKey.currentState?.pop(result);
  }

  @override
  Future<T?>? navigateToNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  @override
  Future<T?>? navigateToAndRemoveUntil<T extends Object?>(
    String routeName,
    bool Function(Route p1) predicate, {
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  @override
  Future<T?>?
      navigateToAndReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushReplacementNamed(
      routeName,
      result: result,
      arguments: arguments,
    );
  }
}
