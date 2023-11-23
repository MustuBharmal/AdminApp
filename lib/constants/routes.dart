import 'package:admin/screens/all_citizen_complaints.dart';
import 'package:flutter/material.dart';

import '../screens/auth_screen.dart';
import '../screens/citizen_complaint_screen.dart';
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
    case CitizenComplaintsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CitizenComplaintsScreen(),
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
