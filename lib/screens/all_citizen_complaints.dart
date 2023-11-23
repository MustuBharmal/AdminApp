import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/complaint_model.dart';
import '../providers/complaint_provider.dart';
import '../widgets/complaint_card.dart';

class CitizenComplaintsScreen extends StatefulWidget {
  const CitizenComplaintsScreen({super.key});

  static const String routeName = '/list-details-screen';

  @override
  State<StatefulWidget> createState() => _CitizenComplaintsScreenState();
}

class _CitizenComplaintsScreenState extends State<CitizenComplaintsScreen> {
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
      Provider.of<ComplaintProvider>(context).fetchComplaintData(context).then((_) {
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
    return Scaffold(
      appBar: AppBar(title: const Text('Citizen Complaints'),),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : RefreshIndicator(
        onRefresh: () async{
          Provider.of<ComplaintProvider>(context,listen: false).fetchComplaintData(context);
        },
        child: Stack(
          children: [
            complaintData.isEmpty
                ?  const Center(
                child: Text(
                  'There is no complaint in your districts',
                  style: TextStyle(fontSize: 20),
                ))
                : ListView.builder(
              itemBuilder: (ctx, i) => ComplaintCard(
                complaintData[i].id,
                complaintData[i].probName,
                complaintData[i].probDsc,
                complaintData[i].off,
                complaintData[i].createdAt,
                complaintData[i].status,
              ),
              itemCount: complaintData.length,
            ),
          ],
        ),
      ),
    );
  }
}
