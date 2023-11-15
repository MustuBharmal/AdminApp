import 'package:admin/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/list_details_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Image.asset('assets/images/profileImg.png'),
            ),
            toolbarHeight: 100,
            title: Text(
              Provider.of<AdminProvider>(context)
                  .adminModel!
                  .name!
                  .toUpperCase(),
            ),
            automaticallyImplyLeading: false,
            elevation: 100,
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.account_balance,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Pending Complaints'),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    arguments: 'pending',
                    ListDetailsScreen.routeName,
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.account_balance,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Processing Complaints'),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.account_balance,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Resolved Complaints'),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    arguments: 'resolved',
                    ListDetailsScreen.routeName,
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Logout'),
                onTap: () {
                  Provider.of<AdminProvider>(context, listen: false).logout();
                },
              ),
              const Divider(),
            ],
          )
        ],
      ),
    );
  }
}
