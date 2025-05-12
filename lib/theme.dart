import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData customTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.grey[50], // Soft background
  textTheme: GoogleFonts.poppinsTextTheme(),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    foregroundColor: Colors.deepOrange,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Colors.deepPurple,
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.deepPurple),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.white,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Colors.deepPurple,
  ),
);
