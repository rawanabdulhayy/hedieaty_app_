import 'package:flutter/material.dart';
import '../../app_colors.dart';

final ThemeData appTheme = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    labelStyle: TextStyle(
      color: AppColors.brightBlue,
      fontSize: 16.0,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.brightBlue, width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.gold, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.navyBlue,
    titleTextStyle: TextStyle(
      color: AppColors.gold,
      fontFamily: "Pacifico",
      fontSize: 27,
    ),
    iconTheme: IconThemeData(
      color: AppColors.gold,
    ),
  ),
  tabBarTheme: TabBarTheme(
    labelColor: AppColors.gold,
    unselectedLabelColor: Colors.grey,
    labelStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        color: AppColors.gold,
        width: 3.0,
      ),
    ),
  ),
);
