
import 'package:agva_app/Screens/User/NotificationScreen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/notifcation':
        return MaterialPageRoute(builder: (context) => NotificationScreen(title: '', body: '',));

      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Text("Not found $routeSettings.name"),
                  ),
                ));
    }
  }
}