import 'package:admin/screens/list_details_screen.dart';
import 'package:flutter/material.dart';

import '../screens/auth_screen.dart';
import '../screens/complaint_screen.dart';
import '../screens/homepage_screen.dart';
import '../screens/inbox_screen.dart';
import '../screens/profile_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case HomePageScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomePageScreen(),
      );
    case ListDetailsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ListDetailsScreen(),
      );
    case ProfileScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ProfileScreen(),
      );
    case ComplaintScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ComplaintScreen(),
      );

    case InboxScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const InboxScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
