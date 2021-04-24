import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:waste_watcher/pages/camera_screen.dart';
import 'package:waste_watcher/profile.dart';
import 'package:waste_watcher/route_page.dart';
import 'package:waste_watcher/settings_screen.dart';
import 'package:waste_watcher/shop_screen.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  int _selectedIndex = 0;

  // ADD ANY ADDITIONAL ROUTES TO THIS ARRAY, SEE route_page.dart
  // MORE INFO
  final List<RoutePage> _pages = <RoutePage>[
    RoutePage(
        title: "Shop",
        iconData: LineIcons.shoppingCart,
        navigatorKey: GlobalKey<NavigatorState>(),
        page: ShopScreen(),
        color: Colors.green),
    RoutePage(
        title: "Scan",
        iconData: LineIcons.camera,
        navigatorKey: GlobalKey<NavigatorState>(),
        page: CameraScreen(),
        color: Colors.deepPurple),
    RoutePage(
        title: "Profile",
        iconData: LineIcons.user,
        navigatorKey: GlobalKey<NavigatorState>(),
        page: ProfileScreen(),
        color: Colors.blue),
    RoutePage(
        title: "Settings",
        iconData: LineIcons.cog,
        navigatorKey: GlobalKey<NavigatorState>(),
        page: SettingsScreen(),
        color: Colors.blueGrey),
  ];

  void _onItemTapped(int index) {
    print(index);
    setState(() {
      if (_selectedIndex != index) {
        _selectedIndex = index;
      } else {
        _pages[_selectedIndex]
            .navigatorKey
            .currentState!
            .popUntil((route) => route.isFirst);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _currentPage = _pages[_selectedIndex];

    return WillPopScope(
        onWillPop: () async =>
            await _currentPage.navigatorKey.currentState!.maybePop(),
        child: Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: _pages.map(_buildRoute).toList(),
          ),
          bottomNavigationBar: SalomonBottomBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: _pages
                  .map((rp) => SalomonBottomBarItem(
                      title: Text(rp.title),
                      icon: Icon(rp.iconData),
                      selectedColor: rp.color))
                  .toList()),
        ));
  }
}

Widget _buildRoute(RoutePage route) => Navigator(
      key: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) => MaterialPageRoute(
          settings: settings, builder: (context) => route.page),
    );
