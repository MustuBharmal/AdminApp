import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import 'font_size.dart';

// COLORS
// const appBarGradient = LinearGradient(
//   colors: [
//     Color.fromARGB(255, 29, 201, 192),
//     Color.fromARGB(255, 125, 221, 216),
//   ],
//   stops: [0.5, 1.0],
// );
final db = FirebaseFirestore.instance;
final firebase = FirebaseAuth.instance;
const String complaintDataRef = 'complaints';

const Color scaffoldBackgroundColor = Colors.white;
const primaryColor = Color(0xffA0E9FF);
const appBarColor = Colors.black26;
const bgColor = Colors.orange;
const greyBackgroundColor = Color(0xffebecee);
var selectedNavBarColor = Colors.cyan[800]!;
const unselectedNavBarColor = Colors.black87;

TextStyle headerStyle = GoogleFonts.poppins(
  color: ThemeColor.black,
  fontSize: FontSize.xxxLarge,
  fontWeight: FontWeight.w600,
);

TextStyle subtitleStyle = GoogleFonts.poppins(
  color: ThemeColor.grey,
  fontSize: FontSize.xLarge,
  fontWeight: FontWeight.w400,
);
TextStyle normalStyle = GoogleFonts.poppins(
  color: ThemeColor.grey,
  fontSize: FontSize.medium,
  fontWeight: FontWeight.w600,
);
TextStyle fieldStyle =GoogleFonts.poppins(
    color: ThemeColor.black, fontSize: FontSize.large
);
TextStyle dropdownStyle =GoogleFonts.poppins(
  color: ThemeColor.black,fontSize: FontSize.large,
);
TextStyle hintStyle = GoogleFonts.poppins(
  color: ThemeColor.textFieldHintColor,
  fontSize: FontSize.large,
  fontWeight: FontWeight.w400,
);
TextStyle titleTextStyle = GoogleFonts.poppins(
  color: ThemeColor.textFieldBgColor,
  fontSize: FontSize.xLarge,
  fontWeight: FontWeight.w500,
);
TextStyle titleStyle = GoogleFonts.poppins(
  color: ThemeColor.black,
  fontSize: FontSize.xLarge,
  fontWeight: FontWeight.w500,
);
String pen = '0';
String on = '0';
String res = '0';
String rej = '0';
