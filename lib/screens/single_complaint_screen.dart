import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/global_variables.dart';
import '../providers/admin_provider.dart';
import '../providers/complaint_provider.dart';
import 'inbox_screen.dart';

class SingleComplaintScreen extends StatefulWidget {
  static const String routeName = '/single-complaint-screen';

  const SingleComplaintScreen({super.key});

  @override
  State<SingleComplaintScreen> createState() => _SingleComplaintScreenState();
}

class _SingleComplaintScreenState extends State<SingleComplaintScreen> {
  List<String> status = ['Pending', 'Ongoing', 'Resolved'];
  bool dataFetched = false;
  var _isInit = true;
  String? selectedStatus;
  bool _isLoading = false;
  late dynamic loadedData;

  @override
  void didChangeDependencies() {
    if (!dataFetched) {
      final passedId = ModalRoute.of(context)!.settings.arguments as String;
      loadedData = Provider.of<ComplaintProvider>(
        context,
        listen: false,
      ).findById(passedId);
    }
    print(dataFetched);
    dataFetched = true;
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ComplaintProvider>(context)
          .fetchComplaintData(context)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void updateFirestore(String newValue) async {

    setState(() {
      _isLoading = true;
      dataFetched = false;

    });
    final CollectionReference itemsCollection = db.collection('complaints');
    await itemsCollection.doc(loadedData.id).set({
      'probName': loadedData.probName,
      'state': loadedData.state,
      'dist': loadedData.dist,
      'city': loadedData.city,
      'off': loadedData.off,
      'subOff': loadedData.subOff,
      'probDsc': loadedData.probDsc,
      'status': selectedStatus?.toLowerCase(),
      'userId': loadedData.userId,
      'imgUrl': loadedData.imgUrl,
      'complaintId': loadedData.complaintId,
      'createdAt': loadedData.createdAt,
    });
    didChangeDependencies();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaint Details'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                width: (deviceSize.width),
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
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.only(
                    bottom: 25, top: 10, right: 20, left: 20),
                child: Wrap(
                  children: [
                    Container(
                        alignment: Alignment.topRight,
                        child: Text(DateFormat.yMMMMd()
                            .format(loadedData.createdAt.toDate()))),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text(
                            loadedData.probName,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("About :- ", style: headerStyle),
                            Text(
                              loadedData.probDsc,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: subtitleStyle,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: <Widget>[
                            Row(
                              children: [
                                const Text(
                                  'Status :- ',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  (loadedData.status).toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: loadedData.status == 'rejected'
                                        ? Colors.red
                                        : loadedData.status == 'resolved'
                                            ? Colors.green
                                            : loadedData.status == 'ongoing'
                                                ? Colors.blue
                                                : Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: DropdownButtonFormField(
                                // hint: Text(loadedData.status),
                                isExpanded: true,
                                style: dropdownStyle,
                                decoration: InputDecoration(
                                  fillColor: ThemeColor.textFieldBgColor,
                                  filled: true,
                                  hintStyle: hintStyle,
                                  labelText: loadedData.status,
                                ),
                                value: selectedStatus,
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
                                    // _isLoading = true;
                                    selectedStatus = value!;
                                    updateFirestore(loadedData.status);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  InboxScreen.routeName,
                                  arguments: loadedData.id,
                                );
                              },
                              child: const Icon(Icons.messenger),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: ThemeColor.lightGrey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8.0),
                              child: Text(
                                'Posted by :- ${(Provider.of<AdminProvider>(context).userModel!.name!).toUpperCase()}',
                                overflow: TextOverflow.clip,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
