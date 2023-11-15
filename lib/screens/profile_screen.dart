import 'dart:math';

import 'package:admin/providers/admin_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profile-name';

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.only(right: 0, left: 0, top: 150, bottom: 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: [
                    SizedBox(height: query.size.height / 32),
                    Center(
                      child: Container(
                        width: query.size.width / 2.5,
                        height: query.size.width / 2.5,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/profileImg.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: query.size.height / 50),
                    Center(
                      child: Text(
                        Provider.of<AdminProvider>(context).adminModel!.name!,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      child: Row(children: [
                        Expanded(
                          flex: 3,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/ad_pending');
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    StreamBuilder(
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
                                          AsyncSnapshot<QuerySnapshot> passed) {
                                        if (passed.connectionState ==
                                            ConnectionState.waiting) {
                                          return Text(
                                            '',
                                            style: TextStyle(
                                              fontSize: 25.0,
                                              color: Colors.grey[800],
                                              fontFamily: 'Roboto',
                                            ),
                                          );
                                        }
                                        return Text(
                                          passed.data!.docs.length.toString(),
                                          style: TextStyle(
                                            fontSize: 25.0,
                                            color: Colors.grey[800],
                                            fontFamily: 'Roboto',
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      'Complaints Pending',
                                      style: TextStyle(
                                        color: Colors.grey[800],
                                        fontFamily: 'Roboto',
                                        fontSize: 3 * query.size.width / 100,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/ad_resolved');
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    StreamBuilder(
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
                                          .where('status',
                                              isEqualTo: 'resolved')
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              resolved) {
                                        if (resolved.connectionState ==
                                            ConnectionState.waiting) {
                                          return Text(
                                            '',
                                            style: TextStyle(
                                              fontSize: 25.0,
                                              color: Colors.grey[800],
                                              fontFamily: 'Roboto',
                                            ),
                                          );
                                        }
                                        return Text(
                                          resolved.data!.docs.length.toString(),
                                          style: TextStyle(
                                            fontSize: 25.0,
                                            color: Colors.grey[800],
                                            fontFamily: 'Roboto',
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 5.0),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Text(
                                        'Complaints Resolved',
                                        style: TextStyle(
                                          color: Colors.grey[800],
                                          fontFamily: 'Roboto',
                                          fontSize: 3 * query.size.width / 100,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ]),
                    ),
                    const SizedBox(height: 15.0),
                    Card(
                      elevation: 5.0,
                      margin: EdgeInsets.symmetric(
                          horizontal: query.size.width / 14,
                          vertical: query.size.height / 80),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Category',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: 'Roboto',
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            const Row(
                              children: [
                                Icon(Icons.person),
                                SizedBox(width: 5.0),
                                Text(
                                  'Admin',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5.0,
                      margin: EdgeInsets.symmetric(
                          horizontal: query.size.width / 14,
                          vertical: query.size.height / 80),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('E-Mail',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'Roboto',
                                )),
                            const SizedBox(height: 5.0),
                            Row(
                              children: [
                                const Icon(Icons.person),
                                const SizedBox(width: 5.0),
                                Text(
                                  Provider.of<AdminProvider>(context)
                                      .adminModel!
                                      .email!,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Stack(
            children: <Widget>[
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.035,
                    color: const Color(0xffA0E9FF),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ClipPath(
                      clipper: CurveClipper(),
                      child: Container(
                        color: const Color(0xffA0E9FF),
                        //constraints: BoxConstraints.expand(),
                      ),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 50.0),
                    const Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20.0,
                        ),
                      ],
                    ),
                    SizedBox(height: query.size.height / 25),
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize:
                            (40 * MediaQuery.of(context).size.height) / 1000,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      // set the "current point"
      ..lineTo(0, size.width / 8)
      ..addArc(
          Rect.fromLTWH(0, size.width / 512 - size.width / 8, size.width / 2,
              size.width / 2),
          pi,
          -pi / 2)
      ..lineTo(4 * size.width / 4, size.width / 2 - size.width / 8)
      ..addArc(
          Rect.fromLTWH(2 * size.width / 4, size.width / 2 - size.width / 8,
              size.width / 2, size.width / 2),
          3.14 + 1.57,
          1.57)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(0, size.width / 8);
    return path;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}
