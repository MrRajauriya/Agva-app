import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  dynamic routeTo(String route, {dynamic arguments}) {
    return navigationKey.currentState?.pushNamed(route, arguments: arguments);
  }

  dynamic goBack() {
    return navigationKey.currentState?.pop();
  }
}