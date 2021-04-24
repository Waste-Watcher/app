import 'package:flutter/widgets.dart';

class RoutePage {
  RoutePage({
    required this.title,
    required this.iconData,
    required this.navigatorKey,
    required this.page,
    required this.color,
  });

  final String title;
  final IconData iconData;
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget page;
  final Color color;
}