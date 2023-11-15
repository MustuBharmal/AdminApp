import 'package:admin/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/complaint_model.dart';
import '../providers/complaint_provider.dart';
import '../widgets/complaint_card.dart';

class ListDetailsScreen extends StatefulWidget {
  const ListDetailsScreen({super.key});

  static const String routeName = '/list-details-screen';

  @override
  State<StatefulWidget> createState() => _ListDetailsScreenState();
}

class _ListDetailsScreenState extends State<ListDetailsScreen> {
  bool dataFetched = false;

  late List<ComplaintModel> complaintData = [];
  var _isInit = true;
  var _isLoading = false;
  List<ComplaintModel>? selectedEventList = [];

  @override
  void didChangeDependencies() {
    if (!dataFetched) {
      String args = ModalRoute.of(context)!.settings.arguments as String;
      if (args == 'all') {
        complaintData = Provider.of<ComplaintProvider>(context).allComplaints;
      } else {
        complaintData =
            Provider.of<ComplaintProvider>(context).getPendingComplaints(args);
      }
    }
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

  @override
  Widget build(BuildContext context) {
    // var query = MediaQuery.of(context);
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, top: 150, bottom: 0),
                  child: ListView.builder(
                    itemBuilder: (ctx, i) => ComplaintCard(
                      complaintData[i].id,
                      complaintData[i].probName,
                      complaintData[i].probDsc,
                      complaintData[i].off,
                      complaintData[i].subOff,
                      complaintData[i].status,
                    ),
                    itemCount: complaintData.length,
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
                              //constraints: BoxConstraints.expand(),
                              color: const Color(0xffA0E9FF),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 50.0),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // CircleAvatar(
                              //   backgroundImage:
                              //       AssetImage('assets/images/profileImg.png'),
                              //   radius: 25.0,
                              // ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'List Of Complaints',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'Amaranth',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
