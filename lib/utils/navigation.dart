import 'package:flutter/material.dart';

class Navigation {
  static Future<T?> push<T>(BuildContext context, Widget page) =>
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );

  static void pop(BuildContext context) => Navigator.pop(context);
}
