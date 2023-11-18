
import 'package:flutter/material.dart';

import 'global_variables.dart';
Color getColor(Set<MaterialState> states) {
  return Colors.black;
}
final ThemeData customTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
    secondary: bgColor,
  ),
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    foregroundColor: Colors.black,
    color: Color(0xffA0E9FF),
  ),
  textTheme:  const TextTheme(
    headlineSmall: TextStyle(color: Colors.black),
    titleLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    labelLarge: TextStyle(color: Colors.black),
  ),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Colors.black),),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
        foregroundColor: MaterialStateProperty.resolveWith(getColor),
      backgroundColor: MaterialStateProperty.all(const Color(0xffA0E9FF)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scaffoldBackgroundColor,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(19),
          borderSide: const BorderSide(color: Colors.black)),
      focusedBorder:  OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: bgColor),
          borderRadius: BorderRadius.circular(15)
      ),
      labelStyle: const TextStyle(
        color:Colors.black,
      )),
  floatingActionButtonTheme:
  const FloatingActionButtonThemeData(backgroundColor: bgColor),
);

// fillColor: Colors.grey.withOpacity(0.1),
abstract class ThemeStyles {
  static ButtonStyle whiteTextButtonStyle = ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
  );
}
