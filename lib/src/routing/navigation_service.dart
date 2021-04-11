import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future navigateTo(String route) => navigatorKey.currentState.pushNamed(route);

  Future navigateAndReplaceTo(String route) =>
      navigatorKey.currentState.pushReplacementNamed(route);

  Future navigateAndRemoveUntil(String route) => navigatorKey.currentState
      .pushNamedAndRemoveUntil(route, ((Route route) => false));

  navigateToBack() {
    navigatorKey.currentState.pop();
  }
}