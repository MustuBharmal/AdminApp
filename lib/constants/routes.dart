import 'package:admin/screens/all_citizen_complaints.dart';
import 'package:flutter/material.dart';

import '../screens/auth_screen.dart';
import '../screens/inbox_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/single_complaint_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case AllCitizenComplaints.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AllCitizenComplaints(),
      );
    case ProfileScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ProfileScreen(),
      );

    case InboxScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const InboxScreen(),
      );
    case SingleComplaintScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SingleComplaintScreen(),
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
