import 'package:flutter/material.dart';

class MyTheme {
  static Color lightBackground = Color(0xffDFECDB);
  static Color blueColor = Color(0xff5D9CEC);
  static Color whiteColor = Color(0xffFFFFFF);
  static Color blackColor = Color(0xff383838);
  static Color greyColor = Color(0xffC8C9CB);
  static Color redColor = Color(0xffEC4B4B);
  static Color greenColor = Color(0xff61E757);
  static Color darkBackground = Color(0xff060E1E);
  static Color offWhiteColor = Color(0xCDCACAE8);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: lightBackground,
    appBarTheme: AppBarTheme(
      color: blueColor,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        fontFamily: 'Poppins',
        color: whiteColor,
      ),
      titleMedium: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: 'Poppins',
          color: blueColor),
      titleSmall: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          fontFamily: 'Poppins',
          color: blackColor),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: blueColor,
      unselectedItemColor: greyColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: blueColor,
      shape: StadiumBorder(
        side: BorderSide(color: whiteColor, width: 3),
      ),
      iconSize: 28,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: whiteColor,
    ),
    dividerTheme: DividerThemeData(color: blueColor, thickness: 2),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: darkBackground,
    appBarTheme: AppBarTheme(
      color: blueColor,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        fontFamily: 'Poppins',
        color: blackColor,
      ),
      titleMedium: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: 'Poppins',
          color: blueColor),
      titleSmall: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          fontFamily: 'Poppins',
          color: whiteColor),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: blueColor,
      unselectedItemColor: greyColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: blueColor,
      shape: StadiumBorder(
        side: BorderSide(color: whiteColor, width: 3),
      ),
      iconSize: 28,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: whiteColor,
    ),
    dividerTheme: DividerThemeData(color: blueColor, thickness: 2),
  );
}
