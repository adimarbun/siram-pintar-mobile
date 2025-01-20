import 'package:flutter/material.dart';

class Navigation {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<T?> push<T>(BuildContext context, Widget page) =>
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );

  static void pop(BuildContext context) => Navigator.pop(context);
}
