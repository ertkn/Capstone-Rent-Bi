import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    // textButtonTheme: TextButtonThemeData(style: ButtonStyle(backgroundColor: Color(0xBE385C89))),
    progressIndicatorTheme: _progressIndicatorThemeData(),
    // bottomAppBarTheme: _bottomAppBarTheme(),
    // elevatedButtonTheme: elevatedButtonTheme(),
    colorScheme: colorScheme(),
    listTileTheme: listTileThemeData(),
    scaffoldBackgroundColor: Colors.white,
    // fontFamily: 'OpenSans',
    backgroundColor: Colors.white,
    appBarTheme: appBarTheme(),
    // textTheme: textTheme(),
    textTheme: GoogleFonts.barlowTextTheme(textTheme()),
    // inputDecorationTheme: inputDecorationTheme(),
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

ProgressIndicatorThemeData _progressIndicatorThemeData() => const ProgressIndicatorThemeData(color: Color(0xBE385C89));

// BottomAppBarTheme _bottomAppBarTheme() => const BottomAppBarTheme(color: Colors.grey,);

/*ElevatedButtonThemeData elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(elevation: 1,minimumSize: Size(100, 10),
      primary: Color(0xBE385C89),
      onPrimary: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),
    ),
  );
}*/

ColorScheme colorScheme() {
  return const ColorScheme.light(
    // primary: Color(0xFF6788AC),
    // secondary: Color(0xFF6788AC),
    primary: Colors.white,
    secondary: Colors.white,
    background: Colors.black,
    onBackground: Colors.black,
    onPrimary: Colors.black,
    onError: Colors.black,
    error: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    // primaryVariant: Colors.black,
    // secondaryVariant: Colors.black,
    surface: Colors.black,
    brightness: Brightness.light,
  );
}

ListTileThemeData listTileThemeData() {
  return const ListTileThemeData(
    tileColor: Color(0x19ffffff),
    textColor: Colors.black,
    style: ListTileStyle.list,
    minVerticalPadding: 0.0,
    contentPadding: EdgeInsets.fromLTRB(15, 0, 30, 0),
    minLeadingWidth: 50.0,
    horizontalTitleGap: 10.0,
  );
}

/*InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}*/

TextTheme textTheme() {
  return const TextTheme(
    subtitle1: TextStyle(
      color: kTextColorB,
      letterSpacing: 0.75,
      wordSpacing: -0.5,
      fontWeight: FontWeight.w500,
    ),
    subtitle2: TextStyle(
      color: kTextColorW,
      letterSpacing: 0.75,
      wordSpacing: -0.5,
      fontWeight: FontWeight.w500,
    ),
    bodyText1: TextStyle(
      color: kTextColorW,
      letterSpacing: 0.75,
      wordSpacing: -0.5,
      fontWeight: FontWeight.w500,
    ),
    bodyText2: TextStyle(
      color: kTextColorB,
      letterSpacing: 1.00,
      wordSpacing: 0.5,
      fontWeight: FontWeight.w400,
    ),
    headline6: TextStyle(
      color: kTextColorB,
      letterSpacing: -0.75,
      wordSpacing: -0.5,
      fontWeight: FontWeight.w500,
    ),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Color(0xFFB6CFEC),
    elevation: 3,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Color(0xFF8B8B8B),
      fontSize: 18,
    ),
    systemOverlayStyle: SystemUiOverlayStyle.light,
  );
}
