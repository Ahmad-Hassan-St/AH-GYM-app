import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

final ThemeData maxPropertyTheme = ThemeData(
  // Primary Colors
  primaryColor: Colors.blue,
  primaryColorBrightness: Brightness.light,
  primaryColorDark: Colors.blue[800],
  primaryColorLight: Colors.blue[100],

  // Accent Colors
  hintColor: Colors.orange,

  // Scaffold Background Color
  scaffoldBackgroundColor: Colors.grey[200],

  // Text Themes
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
    headline2: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
    // ... add more text styles
  ),

  // Button Theme
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),

  // Input Decoration Theme
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
  ),

  // Card Theme
  cardTheme: CardTheme(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  ),

  // Icon Theme
  iconTheme: const IconThemeData(
    color: Colors.blue,
    size: 24.0,
  ),

  // Snackbar Theme
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.grey[800],
    contentTextStyle: const TextStyle(fontSize: 16.0, color: Colors.white),
  ),

  // Divider Theme
  dividerTheme: const DividerThemeData(
    color: Colors.grey,
    thickness: 1.0,
  ),

  // Navigation Bar Theme
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: Colors.blue,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.grey[100],
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
  ),

  // Floating Action Button Theme
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),

  // Tab Bar Theme
  tabBarTheme: TabBarTheme(
    labelColor: Colors.blue,
    unselectedLabelColor: Colors.grey,
  ),

  // Slider Theme
  sliderTheme: SliderThemeData(
    activeTrackColor: Colors.blue,
    inactiveTrackColor: Colors.grey,
    thumbColor: Colors.blue,
    overlayColor: Colors.blue.withAlpha(100),
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
  ),

  // Switch Theme
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all(Colors.blue),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.blue.withOpacity(0.5);
      }
      return Colors.grey;
    }),
  ),

  // Time Picker Theme
  timePickerTheme: TimePickerThemeData(
    backgroundColor: Colors.grey[100],
    dialBackgroundColor: Colors.grey[200],
    hourMinuteTextColor: Colors.black,
    dayPeriodTextColor: Colors.black,
  ),

  // Dialog Theme
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    contentTextStyle: TextStyle(fontSize: 16.0),
  ),

  // Tooltip Theme
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(8.0),
    ),
    textStyle: const TextStyle(color: Colors.white),
  ),

  // Chip Theme
  chipTheme: ChipThemeData(
    backgroundColor: Colors.grey[300],
    selectedColor: Colors.blue,
    secondarySelectedColor: Colors.blue[200],
    labelStyle: TextStyle(fontSize: 14.0),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    shape: StadiumBorder(),
  ),

  // Page Transitions Theme
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),

  // Navigation Rail Theme
  navigationRailTheme: NavigationRailThemeData(
    backgroundColor: Colors.grey[200],
    selectedIconTheme: const IconThemeData(color: Colors.blue),
    unselectedIconTheme: const IconThemeData(color: Colors.grey),
    selectedLabelTextStyle: const TextStyle(color: Colors.blue),
    unselectedLabelTextStyle: const TextStyle(color: Colors.grey),
  ),

  // Cupertino Switch Theme (for iOS-style switches)
  cupertinoOverrideTheme: const CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
  ),

  // Typography Theme
  typography: Typography.material2018(
    platform: TargetPlatform.android,
  ),


  materialTapTargetSize: MaterialTapTargetSize.padded,

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  ),

  // Outlined Button Theme
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      side: const BorderSide(color: Colors.blue),
    ),
  ),
);
