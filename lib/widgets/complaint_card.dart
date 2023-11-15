import 'package:flutter/material.dart';

import '../screens/complaint_screen.dart';

class ComplaintCard extends StatelessWidget {
  final String? id;
  final String probName;
  final String probDsc;
  final String off;
  final String subOff;
  final String status;

  const ComplaintCard(
      this.id, this.probName, this.probDsc, this.off, this.subOff, this.status,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 14,
            ),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11)),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(300),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ComplaintScreen.routeName,
                    arguments: id,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                    children: <Widget>[
                      Text(
                        probName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          const Icon(Icons.calendar_today),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            DateTime.now().toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            ' in ',
                            style: TextStyle(fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            subOff,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              probDsc,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 15),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              status,
                              style: TextStyle(
                                fontSize: 16,
                                color: status == 'rejected'
                                    ? Colors.red
                                    : status == 'resolved'
                                        ? Colors.green
                                        : Colors.orange.shade300,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Status',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
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
    );
  }
}
