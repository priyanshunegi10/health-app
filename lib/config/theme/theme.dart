import 'package:final_year_project/config/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var lightTheme = ThemeData(
  useMaterial3: true,
  inputDecorationTheme: InputDecorationTheme(
    fillColor: lightBgColor,
    filled: true,
    enabledBorder: InputBorder.none,
    prefixIconColor: lightLabelColor,
    labelStyle: TextStyle(
      fontFamily: GoogleFonts.poppins.toString(),
      fontSize: 15,
      color: lightfontColor,
      fontWeight: FontWeight.w500,
    ),
    hintStyle: TextStyle(
      fontFamily: GoogleFonts.poppins.toString(),
      fontSize: 15,
      color: lightfontColor,
      fontWeight: FontWeight.w500,
    ),
  ),

  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    surface: lightBgColor,
    onSurface: lightfontColor,
    primaryContainer: lightDivColor,
    onPrimaryContainer: lightfontColor,
    secondaryContainer: lightLabelColor,
    primary: lightPrimaryColor,
  ),

  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontFamily: GoogleFonts.poppins.toString(),
      fontSize: 24,
      color: lightfontColor,
      fontWeight: FontWeight.w700,
    ),

    headlineMedium: TextStyle(
      fontFamily: GoogleFonts.poppins.toString(),
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ),

    headlineSmall: TextStyle(
      fontFamily: GoogleFonts.poppins.toString(),
      fontSize: 15,
      color: lightfontColor,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      fontFamily: GoogleFonts.poppins.toString(),
      fontSize: 16,
      color: lightfontColor,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontFamily: GoogleFonts.poppins.toString(),
      fontSize: 15,
      color: lightfontColor,
      fontWeight: FontWeight.w400,
    ),

    bodySmall: TextStyle(
      fontFamily: GoogleFonts.poppins.toString(),
      fontSize: 13,
      color: lightfontColor,
    ),
    labelSmall: TextStyle(
      fontFamily: GoogleFonts.poppins.toString(),
      fontSize: 13,
      color: lightLabelColor,
      fontWeight: FontWeight.w300,
    ),
  ),
);

var darkTheme = ThemeData(
  useMaterial3: true,
  inputDecorationTheme: InputDecorationTheme(
    fillColor: darkBgColor,
    filled: true,
    enabledBorder: InputBorder.none,
    prefixIconColor: darklabelColor,
    labelStyle: TextStyle(
      fontFamily: GoogleFonts.poppins.toString(),
      fontSize: 15,
      color: darkFontColor,
      fontWeight: FontWeight.w500,
    ),
    hintStyle: TextStyle(
      fontFamily: GoogleFonts.poppins.toString(),
      fontSize: 15,
      color: darkFontColor,
      fontWeight: FontWeight.w500,
    ),
  ),

  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    surface: darkBgColor,
    onSurface: darkFontColor,
    primaryContainer: darkDivColor,
    onPrimaryContainer: darkFontColor,
    secondaryContainer: darklabelColor,
    primary: darkPrimaryColor,
  ),

  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontFamily: GoogleFonts.poppins.toString(),
      fontSize: 24,
      color: darkFontColor,
      fontWeight: FontWeight.w700,
    ),

    headlineMedium: TextStyle(
      fontFamily: GoogleFonts.poppins.toString(),
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ),

    headlineSmall: TextStyle(
      fontFamily: GoogleFonts.poppins.toString(),
      fontSize: 15,
      color: darkFontColor,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      fontFamily: GoogleFonts.poppins.toString(),
      fontSize: 16,
      color: darkFontColor,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontFamily: GoogleFonts.poppins.toString(),
      fontSize: 15,
      color: darkFontColor,
      fontWeight: FontWeight.w400,
    ),

    bodySmall: TextStyle(
      fontFamily: GoogleFonts.poppins.toString(),
      fontSize: 13,
      color: darkFontColor,
    ),
    labelSmall: TextStyle(
      fontFamily: GoogleFonts.poppins.toString(),
      fontSize: 13,
      color: darklabelColor,
      fontWeight: FontWeight.w300,
    ),
  ),
);
