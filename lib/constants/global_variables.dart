import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final db = FirebaseFirestore.instance;
final firebase = FirebaseAuth.instance;
const String complaintDataRef = 'complaints';

// COLORS
const appBarGradient = LinearGradient(
  colors: [
    Color.fromARGB(255, 29, 201, 192),
    Color.fromARGB(255, 125, 221, 216),
  ],
  stops: [0.5, 1.0],
);

const Color scaffoldBackgroundColor = Colors.white;
const primaryColor = Color(0xffA0E9FF);
const appBarColor = Colors.black26;
const bgColor = Colors.orange;
const greyBackgroundColor = Color(0xffebecee);
var selectedNavBarColor = Colors.cyan[800]!;
const unselectedNavBarColor = Colors.black87;
