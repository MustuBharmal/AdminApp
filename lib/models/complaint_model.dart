import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintModel {
  String id;
  final String probName;
  final String state;
  final String dist;
  final String city;
  final String off;
  final String subOff;
  final String probDsc;
  final String status;
  final String? userId;
  late String imgUrl;
  final String complaintId;
  final Timestamp createdAt;

  ComplaintModel({
    required this.id,
    required this.probName,
    required this.state,
    required this.dist,
    required this.city,
    required this.off,
    required this.subOff,
    required this.probDsc,
    required this.status,
    required this.userId,
    required this.imgUrl,
    required this.complaintId,
    required this.createdAt,
  });

  toJson() {
    return {
      'probName': probName,
      'state': state,
      'dist': dist,
      'city': city,
      'off': off,
      'subOff': subOff,
      'probDsc': probDsc,
      'status': status,
      'userId': userId,
      'imgUrl': imgUrl,
      'complaintId': complaintId,
      'createdAt': createdAt,
    };
  }

  factory ComplaintModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ComplaintModel(
      id: document.id,
      probName: data['probName'],
      imgUrl: data['imgUrl'],
      state: data['state'],
      dist: data['dist'],
      city: data['city'],
      off: data['off'],
      subOff: data['subOff'],
      probDsc: data['probDsc'],
      userId: data['userId'],
      status: data['status'],
      complaintId: data['complaintId'],
      createdAt: data['createdAt'],
    );
  }
}
