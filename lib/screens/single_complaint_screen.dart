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
  // final String uid;
  // const SingleComplaintScreen({super.key, required this.uid});
  @override
  State<SingleComplaintScreen> createState() => _SingleComplaintScreenState();
}

class _SingleComplaintScreenState extends State<SingleComplaintScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration.zero).then(
  //         (_) => Provider.of<AdminProvider>(
  //       context,
  //       listen: false,
  //     ).fetchCitizenData(),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    final passedId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedData = Provider.of<ComplaintProvider>(
      context,
      listen: false,
    ).findById(passedId);
    String? passing(String uid){
      return loadedData.userId;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaint Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          width: (deviceSize.width),
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
              color: ThemeColor.shadow,
              blurRadius: 10,
              spreadRadius: 0.1,
              offset: Offset(0, 10),
            )
          ], color: ThemeColor.white, borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.only(bottom: 25,top: 10, right: 20,left: 20),
          child: Wrap(
            children: [
              // Positioned(right: 10.0,child: Text('9th November')),
              Container(alignment: Alignment.topRight,child:  Text(DateFormat.yMMMMd().format(loadedData.createdAt.toDate()))),
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
                      const Text("About :- ", style: headerStyle),
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
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20 ,),
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
                      const SizedBox(width: 50,),
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
