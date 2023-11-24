import 'package:admin/providers/admin_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/global_variables.dart';
import '../providers/complaint_provider.dart';
import 'inbox_screen.dart';

class ComplaintScreen extends StatefulWidget {
  static const String routeName = '/complaint-screen';

  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  List<String> status = ['Pending', 'Ongoing', 'Resolved'];

  String selectedStatus = 'Pending';

  @override
  Widget build(BuildContext context) {
    final passedId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedData = Provider.of<ComplaintProvider>(
      context,
      listen: false,
    ).findById(passedId);
    void updateFirestore(String newValue) async {
      final CollectionReference itemsCollection = db.collection('complaints');
      await itemsCollection.doc(loadedData.id).set({
        'probName': loadedData.probName,
        'state': loadedData.state,
        'dist': loadedData.dist,
        'city': loadedData.city,
        'off': loadedData.off,
        'subOff': loadedData.subOff,
        'probDsc': loadedData.probDsc,
        'status': selectedStatus.toLowerCase(),
        'userId': loadedData.userId,
        'imgUrl': loadedData.imgUrl,
        'complaintId': loadedData.complaintId,
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaint Details'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          children: <Widget>[
            Text(
              loadedData.probName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: <Widget>[
                const Text(
                  'Posted by ',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Text(
                    (Provider.of<AdminProvider>(context).adminModel!.name!)
                        .toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: <Widget>[
                Flexible(
                  child: Text(
                    loadedData.probDsc,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    (loadedData.status).toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      color: loadedData.status == 'Rejected'
                          ? Colors.red
                          : loadedData.status == 'Solved'
                          ? Colors.green
                          : loadedData.status == 'In Progress'
                          ? Colors.blue
                          : loadedData.status == 'Passed'
                          ? Colors.cyan
                          : Colors.deepOrange,
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
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        arguments: loadedData.id,
                        InboxScreen.routeName,
                      );
                    },
                    child: const Icon(Icons.messenger),
                  ),
                  if (loadedData.status == 'pending')
                    DropdownButton(
                      hint: const Text('Pending'),
                      isExpanded: true,
                      value: loadedData.status,
                      items: status
                          .map(
                            (String status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ),
                      )
                          .toList(),
                      onChanged: (String? value) {
                        setState(() {
                          loadedData.status = value!;
                          updateFirestore(loadedData.status);
                        });
                      },
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}