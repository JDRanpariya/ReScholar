import 'dart:math';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:heroicons/heroicons.dart';

import 'package:rescholar/screens/app_profile.dart';
import 'package:rescholar/screens/library.dart';
import 'package:rescholar/screens/re_search.dart';
import 'package:rescholar/models/rescholar_user.dart';
import 'package:rescholar/widgets/header.dart';
import 'package:rescholar/models/user_library.dart';

/// Builds a persistent bottom navigation bar based on the PersistenBottomNavBar
/// Flutter package with access to the three primary pages: [Library], [ReSearch],
/// and the [AppProfile].
class NavigationBar extends StatefulWidget {
  final readUserLibrary;

  NavigationBar({Key key, this.readUserLibrary}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);

    // If this line doesn't setState with the proper initial read of User Library
    // from the file system, replace with a FutureBuilder
    context.read<UserLibrary>().initRead().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ReScholarUser>(context);
    // debugPrint("DEBUG: ${context.read<UserLibrary>().papers}");

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(context),
      items: _navBarsItems(user),
      backgroundColor: Color(0xFF1C1C1C),
      resizeToAvoidBottomInset: true,
      stateManagement: true,
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

List<Widget> _buildScreens(BuildContext context) {
  return [
    Library(
      header: Header(
          Icon(
            FluentIcons.library_20_filled,
            size: 54,
          ),
          [
            const Color(0xFFFFA740),
            const Color(0xFFFFCA8B),
          ],
          "papers",
          [
            const Color(0xFFFFC27A),
            const Color(0xFF8BB6FF),
          ],
          true,
          [
            const Color(0xFF9DD0FF),
            const Color(0xFF4880DE),
          ]),
      renderGreeting: true,
      librarySection: "Papers",
    ),
    ReSearch(),
    AppProfile(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems(user) {
  return [
    PersistentBottomNavBarItem(
        icon: Icon(FluentIcons.library_20_filled, size: 28.0),
        title: ("Library"),
        textStyle: TextStyle(fontSize: 16.0),
        activeColorPrimary: Color(0xFFFF9536),
        inactiveColorPrimary: Colors.white70,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: "/library_papers", onGenerateRoute: _routes())),
    PersistentBottomNavBarItem(
      icon: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: HeroIcon(HeroIcons.searchCircle, solid: true, size: 32.0),
      ),
      title: ("ReSearch"),
      textStyle: TextStyle(fontSize: 16.0),
      activeColorPrimary: Color(0xFF4880DE),
      inactiveColorPrimary: Colors.white70,
    ),
    PersistentBottomNavBarItem(
      // TODO: Cache user profile picture for quicker render
      icon: user.isAnonymous == false
          ? CircleAvatar(
              radius: 15.0, backgroundImage: NetworkImage(user.profilePicture))
          : Container(child: Icon(Icons.account_circle_rounded, size: 30.0)),
      title: ("App Profile"),
      textStyle: TextStyle(fontSize: 16.0),
      activeColorPrimary: Color(0xFFEB5757),
      inactiveColorPrimary: Colors.white70,
    ),
  ];
}

RouteFactory _routes() {
  return (settings) {
    final Map<String, dynamic> arguments = settings.arguments;
    Widget screen;
    switch (settings.name) {
      case "/library_papers":
        screen = Library(
            header: arguments['header'],
            renderGreeting: arguments['renderGreeting'],
            folderBar: arguments['folderBar'],
            optionBar: arguments['optionBar'],
            librarySection: arguments['librarySection']);
        break;
      case "/library_favourites":
        screen = Library(
            header: arguments['header'],
            renderGreeting: arguments['renderGreeting'],
            folderBar: arguments['folderBar'],
            optionBar: arguments['optionBar'],
            librarySection: arguments['librarySection']);
        break;
      case "/library_archive":
        screen = Library(
            header: arguments['header'],
            renderGreeting: arguments['renderGreeting'],
            folderBar: arguments['folderBar'],
            optionBar: arguments['optionBar'],
            librarySection: arguments['librarySection']);
        break;
      case "/library_recycle_bin":
        screen = Library(
            header: arguments['header'],
            renderGreeting: arguments['renderGreeting'],
            folderBar: arguments['folderBar'],
            optionBar: arguments['optionBar'],
            librarySection: arguments['librarySection']);
        break;
      case "/library_folders":
        screen = Library(
            header: arguments['header'],
            renderGreeting: arguments['renderGreeting'],
            folderBar: arguments['folderBar'],
            optionBar: arguments['optionBar'],
            librarySection: arguments['librarySection']);
        break;
      case "/re_search":
        screen = ReSearch();
        break;
      case "/app_profile":
        screen = AppProfile();
        break;
      default:
        return null;
    }
    return MaterialPageRoute(builder: (BuildContext context) => screen);
  };
}
