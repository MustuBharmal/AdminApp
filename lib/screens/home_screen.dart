
import 'package:admin/providers/admin_provider.dart';
import 'package:admin/screens/all_citizen_complaints.dart';
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
    Future.delayed(Duration.zero).then(
        (_) => Provider.of<AdminProvider>(context, listen: false).getUserData());
  }


  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
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
                                style:TextStyle(
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
                        width: double.infinity,
                        height: 145,
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
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Flexible(
                                child: SizedBox(
                                  width: (deviceSize.width),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Departments",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: ThemeColor.white),
                                      ),
                                      const Text(
                                        "Sub-Offices",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: ThemeColor.white),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.pushNamed(
                                          //     context, Department.routeName);
                                        },
                                        child: Container(
                                          width: deviceSize.width / 3,
                                          height: deviceSize.height / 18,
                                          decoration: BoxDecoration(
                                              color: ThemeColor.secondary,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: const Center(
                                            child: Text(
                                              "View Departments",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: ThemeColor.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ThemeColor.secondary),
                                child: Center(
                                  child: FutureBuilder(
                                    future: getNumberOfUsers(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data,
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
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
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
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Register Complaint",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: ThemeColor.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              InkWell(
                                onTap: () {
                                  // Navigator.pushNamed(
                                  //     context, AddComplaints.routeName);
                                },
                                child: Container(
                                  width: 70,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: ThemeColor.secondary,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Center(
                                    child: Icon(LineIcons.plus,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
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
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Select Language",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: ThemeColor.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              InkWell(
                                onTap: () {
                                  // buildLanguageDialog(context);
                                },
                                child: Container(
                                  width: 70,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: ThemeColor.secondary,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Center(
                                    child: Icon(LineIcons.language,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                                  CitizenComplaintsScreen.routeName,
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
                                    "Citizen Complaints",
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
}
