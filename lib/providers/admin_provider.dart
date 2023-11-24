import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/global_variables.dart';
import '../models/admin_model.dart';
import '../models/states_dist_model.dart';

class AdminProvider with ChangeNotifier {
  AdminModel? adminModel;
  AdminModel? userModel;

  Future<void> getUserData() async {
    await db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (querySnapshot) {
        if (querySnapshot.data() != null) {
          adminModel = AdminModel.fromJson(querySnapshot.data()!);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    notifyListeners();
  }

  Future<void> fetchCitizenData(String? uid) async {
    await db.collection('users').doc(uid).get().then(
      (querySnapshot) {
        if (querySnapshot.data() != null) {
          userModel = AdminModel.fromJson(querySnapshot.data()!);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    notifyListeners();
  }

  Future<List<StateModel>> fetchData() async {
    try {
      final jsonText =
          await rootBundle.loadString('assets/states-and-districts.json');
      final jsonData = json.decode(jsonText);
      List<StateModel> stateList = [];

      for (var stateData in jsonData['states']) {
        final stateName = stateData['state'];
        final districts = List<String>.from(stateData['districts']);
        stateList.add(StateModel(stateName, districts));
      }

      return stateList;
    } catch (e) {
      throw Exception('Failed to load data; $e');
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    adminModel = null;
    notifyListeners();
  }
}
