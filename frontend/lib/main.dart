import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:frontend/screens/LibraryScreen.dart';
import 'package:frontend/screens/SearchScreen.dart';
import 'package:frontend/screens/ProfileScreen.dart';
import 'package:fluentui_icons/fluentui_icons.dart'; //flutent icons

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    theme: ThemeData(
      brightness: Brightness.dark,
    ),
    themeMode: ThemeMode.dark,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Color(0xFF1C1C1C),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears.
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style9, // Choose the nav bar style with this property.
    );
  }
}

List<Widget> _buildScreens() {
  return [
    LibraryScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];
}

// The bottom nav bar opacity isn't implemented. the opacity on the figma prototype is at 10%
List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(
        FluentSystemIcons.ic_fluent_library_filled,
      ),
      title: ("Library"),
      activeColorPrimary: Color(0xFFFF9536),
      inactiveColorPrimary: Colors.white70,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(FluentSystemIcons.ic_fluent_search_filled),
      title: ("Search"),
      activeColorPrimary: Color(0xFFFF9536),
      inactiveColorPrimary: Colors.white70,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.account_circle_rounded),
      title: ("Profile"),
      activeColorPrimary: Color(0xFFFF9536),
      inactiveColorPrimary: Colors.white70,
    ),
  ];
}
