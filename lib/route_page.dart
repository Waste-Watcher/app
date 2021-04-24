import 'package:flutter/widgets.dart';

class RoutePage {
  RoutePage({
    required this.title,
    required this.iconData,
    required this.navigatorKey,
    required this.page
  });

  final String title;
  final IconData iconData;
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget page;
}