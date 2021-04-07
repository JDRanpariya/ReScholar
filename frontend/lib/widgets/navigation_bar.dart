import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:fluentui_icons/fluentui_icons.dart';

import '../screens/library.dart';
import '../screens/re_search.dart';
import '../screens/app_profile.dart';
import '../models/customIcons.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
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
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
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
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style9,
    );
  }
}

List<Widget> _buildScreens() {
  return [
    Library(),
    ReSearch(),
    AppProfile(),
  ];
}

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
      icon: Icon(CustomIcons.heroicons_solid_search_circle),
      title: ("ReSearch"),
      activeColorPrimary: Color(0xFF4880DE),
      inactiveColorPrimary: Colors.white70,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.account_circle_rounded),
      title: ("App Profile"),
      activeColorPrimary: Color(0xFFFF9536),
      inactiveColorPrimary: Colors.white70,
    ),
  ];
}
