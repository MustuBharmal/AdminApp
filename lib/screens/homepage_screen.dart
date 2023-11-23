import 'package:admin/providers/admin_provider.dart';
import 'package:admin/screens/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/button_widget.dart';
import 'all_citizen_complaints.dart';

var imageString1 = "assets/images/notification_1.png";

class HomePageScreen extends StatefulWidget {
  static const String routeName = '/home-screen';

  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  void setupPushNotification() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();

    // notificationSettings.announcement;
    await fcm.getToken();
    fcm.subscribeToTopic('complaints');
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then(
      (_) => Provider.of<AdminProvider>(
        context,
        listen: false,
      ).getUserData(),
    );
    setupPushNotification();
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                ProfileScreen.routeName,
              );
            },
            icon: const Icon(Icons.person),
          )
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(
            Icons.abc,
          ),
          Icon(
            Icons.favorite,
          ),
          Icon(Icons.settings)
        ],
      ),
      drawer: const AppDrawer(),
      body: Provider.of<AdminProvider>(context).adminModel == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Provider.of<AdminProvider>(context).adminModel!.role == 'citizen'
              ? SizedBox(
                  height: query.height,
                  width: query.width,
                  child: AlertDialog(
                    title: const Text(
                      'Invalid User',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    content: const Text('Do you want to logout?'),
                    actions: [
                      TextButton(onPressed: () {}, child: const Text('No')),
                      TextButton(
                          onPressed: () {
                            Provider.of<AdminProvider>(context, listen: false)
                                .logout();
                          },
                          child: const Text('Yes')),
                    ],
                  ),
                )
              : Container(
                  height: query.height,
                  width: query.width,
                  margin: const EdgeInsets.symmetric(vertical: 200),
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ButtonWidget(
                              imageString1,
                              "Complaint Form",
                              CitizenComplaintsScreen.routeName,
                            ),
                            Column(
                              children: [
                                titleSection('Complaint Form',
                                    'An upcoming event is a\nplanned occurrence that\nis scheduled to take place\nin the near future'),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget titleSection(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            description,
            softWrap: true,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
