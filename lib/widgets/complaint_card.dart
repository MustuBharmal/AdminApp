import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../constants/colors.dart';
import '../screens/citizen_complaint_screen.dart';
import '../screens/single_complaint_screen.dart';

class ComplaintCard extends StatelessWidget {
  final String? id;
  final String probName;
  final String probDsc;
  final String off;
  final Timestamp timestamp;
  final String status;

  const ComplaintCard(
      this.id,
      this.probName,
      this.probDsc,
      this.off,
      this.timestamp,
      this.status, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: (deviceSize.width),
              height: (deviceSize.height / 4.5),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: ThemeColor.shadow,
                      blurRadius: 10,
                      spreadRadius: 0.1,
                      offset: Offset(0, 10),
                    )
                  ],
                  color: ThemeColor.white,
                  borderRadius: BorderRadius.circular(20)),
              child: InkWell(
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(builder: ()=>{
                  //
                  //   });
                  // );
                },
                child: SizedBox(
                  width: 70,
                  height: 35,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          probName,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(LineIcons.calendar),
                            Text(
                              ' :- ${DateFormat.yMMMMd().format(timestamp.toDate())}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),

                        Flexible(
                          child: Text(
                            'Problem Description :- $probDsc',
                            overflow: TextOverflow.visible,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'Status :- ',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  status.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: status == 'Rejected'
                                        ? Colors.red
                                        : status == 'Solved'
                                        ? Colors.green
                                        : status == 'In Progress'
                                        ? Colors.blue
                                        : status == 'Passed'
                                        ? Colors.cyan
                                        : Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
