import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/global_variables.dart';
import '../models/complaint_model.dart';
import 'admin_provider.dart';

class ComplaintProvider with ChangeNotifier {
  List<ComplaintModel> allComplaints = [];
  List<ComplaintModel> filteredComplaints = [];

  Future<void> fetchComplaintData(BuildContext context) async {
    allComplaints.clear();
    final docRef = db.collection('complaints');
    await docRef
        .where('dist',
            isEqualTo: Provider.of<AdminProvider>(context, listen: false)
                .adminModel!
                .dist)
        .orderBy('createdAt', descending: true)
        .get()
        .then(
      (ref) {
        for (var element in ref.docs) {
          allComplaints.add(ComplaintModel.fromSnapshot(element));
        }
      },
      onError: (e) => print('Error getting document: $e'),
    );
    notifyListeners();
  }

  Future<void> addComplaintData(ComplaintModel data) async {
    try {
      final doc = await db.collection(complaintDataRef).add(data.toJson());
      if (doc.id != '') {
        data.id = doc.id;
      }
      allComplaints.add(data);
      notifyListeners();
    } catch (error) {
      // print(error);
      throw error;
    }
  }

  List<ComplaintModel> get complaint {
    return [...allComplaints];
  }

  List<ComplaintModel> getPendingComplaints(String status) {
    List<ComplaintModel> userList = [];
    userList.addAll(allComplaints.where((element) => element.status == status));
    return userList;
  }

  List<ComplaintModel> getRejectedComplaints() {
    List<ComplaintModel> userList = [];
    userList
        .addAll(allComplaints.where((element) => element.status == 'rejected'));
    return userList;
  }

  ComplaintModel findById(String id) {
    return allComplaints.firstWhere((element) => element.id == id);
  }
}
