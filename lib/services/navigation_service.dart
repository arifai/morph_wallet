import 'package:flutter/material.dart';

/// Navigation service without state.
class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop() {
    return _navigationKey.currentState?.pop();
  }

  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return _navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> moveTo(String routeName,
      {Object? arguments, Object? result}) {
    return _navigationKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments, result: result);
  }

  Future<dynamic> pushTo(String routeName, {Object? arguments}) {
    return _navigationKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }
}
