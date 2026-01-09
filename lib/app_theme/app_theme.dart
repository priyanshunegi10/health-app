import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // 1. Define your Brand Colors
  static const Color primaryColor = Color(0xff22BED5);
  static const Color darkCyan = Color(0xff0294AD);
  
  // 2. Light Theme
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white, // For bottom nav and cards
    
    // Text Styling
    textTheme: GoogleFonts.latoTextTheme(
      ThemeData.light().textTheme,
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: Colors.black),
    
    // Color Scheme (This helps widgets know what color to use automatically)
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: darkCyan,
      surface: Colors.white,
      onSurface: Colors.black, // Text color on white background
    ),
  );

  // 3. Dark Theme
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: const Color(0xFF121212), // Standard Material Dark Grey
    cardColor: const Color(0xFF1E1E1E), // Slightly lighter grey for cards/nav
    
    // Text Styling
    textTheme: GoogleFonts.latoTextTheme(
      ThemeData.dark().textTheme,
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: Colors.white),

    // Color Scheme
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: darkCyan,
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white, // Text color on dark background
    ),
  );
}