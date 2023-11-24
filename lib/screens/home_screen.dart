import 'package:admin/constants/global_variables.dart';
import 'package:admin/providers/admin_provider.dart';
import 'package:admin/screens/all_citizen_complaints.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<String> getNumberOfUsers() async {
    // String numberOfUsers='N';
    return '6';
    // return await dbReference.child('users').once().then(
    //       (value) {
    //     var data = value.snapshot.value;
    //
    //     String numberOfUsers =
    //     Map<String, dynamic>.from(data as Map<Object?, Object?>)
    //         .length
    //         .toString();
    //
    //     return numberOfUsers;
    //   },
    // );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) =>
        Provider.of<AdminProvider>(context, listen: false).getUserData());
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(),
      // drawer: const AppDrawer(),
      body: Provider.of<AdminProvider>(context).adminModel == null
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Welcome,",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                Provider.of<AdminProvider>(context)
                                    .adminModel!
                                    .name!,
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Provider.of<AdminProvider>(context, listen: false)
                                  .logout();
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.03),
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Center(
                                child: Icon(LineIcons.alternateSignOut),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: deviceSize.width,
                        height: deviceSize.height / 4.5,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: ThemeColor.shadow,
                                blurRadius: 100,
                                spreadRadius: 5,
                                offset: Offset(0, 25)),
                          ],
                          borderRadius: BorderRadius.circular(30),
                          color: ThemeColor.primary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 20,left: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: deviceSize.width / 3.5,
                                    height: deviceSize.height/5.5,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ThemeColor.secondary),
                                    child: Center(
                                      child: StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('complaints')
                                            .where(
                                              'dist',
                                              isEqualTo:
                                                  Provider.of<AdminProvider>(
                                                          context)
                                                      .adminModel!
                                                      .dist,
                                            )
                                            .where('status', whereIn: [
                                          'pending',
                                        ]).snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot passed) {
                                          if (passed.hasData) {
                                            return Text(
                                              passed.data!.docs.length
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold,
                                                  color: ThemeColor.white),
                                            );
                                          } else {
                                            return const CircularProgressIndicator();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    'Pending Complaint',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20,),
                              Column(
                                children: [
                                  Container(
                                    width: deviceSize.width / 3.5,
                                    height: deviceSize.height/5.5,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ThemeColor.secondary),
                                    child: Center(
                                      child: StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('complaints')
                                            .where(
                                          'dist',
                                          isEqualTo:
                                          Provider.of<AdminProvider>(
                                              context)
                                              .adminModel!
                                              .dist,
                                        )
                                            .where('status', whereIn: [
                                          'resolved',
                                        ]).snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot passed) {
                                          if (passed.hasData) {
                                            return Text(
                                              passed.data!.docs.length
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold,
                                                  color: ThemeColor.white),
                                            );
                                          } else {
                                            return const CircularProgressIndicator();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    'Resolved Complaint',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: ThemeColor.shadow,
                                  blurRadius: 10,
                                  spreadRadius: 0.1,
                                  offset: Offset(0, 10)),
                            ],
                            color: ThemeColor.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Complaints",
                              style: titleStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                filterButton('Pending'),
                                filterButton('Ongoing'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  AllCitizenComplaints.routeName,
                                  arguments: 'all');
                            },
                            child: Container(
                              width: (deviceSize.width / 2.5),
                              height: (deviceSize.width / 2.5),
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: ThemeColor.shadow,
                                        blurRadius: 10,
                                        spreadRadius: 0.1,
                                        offset: Offset(0, 10)),
                                  ],
                                  color: ThemeColor.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Icon(
                                    LineIcons.chevronCircleRight,
                                    size: 50,
                                    color: ThemeColor.primary,
                                  ),
                                  Text(
                                    "All Complaints",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: ThemeColor.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.pushNamed(
                              //     context, HelpingBot.routeName);
                            },
                            child: Container(
                              width: (deviceSize.width / 2.5),
                              height: (deviceSize.width / 2.5),
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: ThemeColor.shadow,
                                        blurRadius: 10,
                                        spreadRadius: 0.1,
                                        offset: Offset(0, 10)),
                                  ],
                                  color: ThemeColor.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Icon(
                                    LineIcons.question,
                                    size: 50,
                                    color: ThemeColor.primary,
                                  ),
                                  Text(
                                    "Helping Bot",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: ThemeColor.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget filterButton(String status) {
    var deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AllCitizenComplaints.routeName,
                  arguments: status.toLowerCase());
            },
            child: Icon(
              LineIcons.filter,
              size: deviceSize.width / 12,
            ),
          ),
          Text(
            status,
            style: normalStyle,
          ),
        ],
      ),
    );
  }
}
