import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/dimension_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: color,
    scaffoldBackgroundColor: ColorConstants.colorWhite,
    appBarTheme: const AppBarTheme(
      color: ColorConstants.colorWhite,
      titleTextStyle: TextStyle(
          color: ColorConstants.colorBlack
      ),
      iconTheme: IconThemeData(
        color: ColorConstants.colorWhite,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.white,
      primaryVariant: Colors.white38,
      brightness: Brightness.light,
    ),
    cardTheme: const CardTheme(
      color: ColorConstants.colorWhite,
    ),
    iconTheme: const IconThemeData(
      color: ColorConstants.colorBlack,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: ColorConstants.colorWhite,
        fontSize: 20.0,
      ),
      labelMedium: TextStyle(
        color: ColorConstants.colorWhite,
        fontSize: 18.0,
      ),
    ),
      drawerTheme: const DrawerThemeData(
          backgroundColor: ColorConstants.colorWhite
      ),
    cardColor: ColorConstants.colorWhite,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorConstants.colorWhite,
      selectedLabelStyle: TextStyle(
          color: ColorConstants.colorBlack,
          fontWeight: FontWeight.w600,
          fontSize: DimensionConstants.d14.sp
      ),
      unselectedLabelStyle: TextStyle(
          color: ColorConstants.colorBlack,
          fontWeight: FontWeight.w400,
          fontSize: DimensionConstants.d14.sp,
      ),
      selectedItemColor: ColorConstants.colorBlack,
      unselectedItemColor: ColorConstants.colorBlack,
    )
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: color,
    scaffoldBackgroundColor: ColorConstants.colorBlack,
    appBarTheme: const AppBarTheme(
      color: ColorConstants.colorBlack,
      titleTextStyle: TextStyle(
        color: ColorConstants.colorWhite
      ),
      iconTheme: IconThemeData(
        color: ColorConstants.colorWhite,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.black,
      primaryVariant: Colors.black,
      brightness: Brightness.dark,
    ),
    cardTheme: const CardTheme(
      color: ColorConstants.colorBlack,
    ),
    iconTheme: const IconThemeData(
      color: ColorConstants.colorWhite,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: ColorConstants.colorWhite,
        fontSize: 20.0,
      ),
      labelMedium: TextStyle(
        color: ColorConstants.colorWhite,
        fontSize: 18.0,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: ColorConstants.colorBlack
    ),
      cardColor: ColorConstants.colorWhite,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black12,
          selectedLabelStyle: TextStyle(
              color: ColorConstants.colorWhite,
              fontWeight: FontWeight.w600,
              fontSize: DimensionConstants.d14.sp
          ),
        unselectedLabelStyle: TextStyle(
            color: ColorConstants.colorWhite,
            fontWeight: FontWeight.w400,
            fontSize: DimensionConstants.d14.sp
        ),
        selectedItemColor: ColorConstants.colorWhite,
        unselectedItemColor: ColorConstants.colorWhite,
      )
  );

 static MaterialColor color = const MaterialColor(0xFFFDB726, <int, Color>{
    50: Color(0xFFFDB726),
    100: Color(0xFFFDB726),
    200: Color(0xFFFDB726),
    300: Color(0xFFFDB726),
    400: Color(0xFFFDB726),
    500: Color(0xFFFDB726),
    600: Color(0xFFFDB726),
    700: Color(0xFFFDB726),
    800: Color(0xFFFDB726),
    900: Color(0xFFFDB726),
  });
}