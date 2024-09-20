import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/app/utils/colors_app.dart';

final ThemeData myTheme = ThemeData(
  primarySwatch: const MaterialColor(4284065214, {
    50: Color(0xffedf5f8),
    100: Color(0xffdaebf1),
    200: Color(0xffb6d7e2),
    300: Color(0xff91c3d4),
    400: Color(0xff6cb0c6),
    500: Color(0xff489cb7),
    600: Color(0xff397d93),
    700: Color(0xff2b5d6e),
    800: Color(0xff1d3e49),
    900: Color(0xff0e1f25),
  }),
  brightness: Brightness.light,
  primaryColor: ColorsApp.primaryColor,
  primaryColorLight: const Color(0xffdaebf1),
  primaryColorDark: const Color(0xff2b5d6e),
  canvasColor: const Color(0xfffafafa),
  scaffoldBackgroundColor: Colors.white,
  cardColor: const Color(0xffffffff),
  dividerColor: const Color(0x1f000000),
  highlightColor: const Color(0x66bcbcbc),
  splashColor: const Color(0x66c8c8c8),
  unselectedWidgetColor: const Color(0x8a000000),
  disabledColor: const Color(0x61000000),
  secondaryHeaderColor: const Color(0xffedf5f8),
  dialogBackgroundColor: const Color(0xffffffff),
  indicatorColor: const Color(0xff489cb7),
  hintColor: const Color(0x8a000000),
  buttonTheme: const ButtonThemeData(
    padding: EdgeInsets.only(left: 16, right: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(32)),
    ),
    buttonColor: Color(0xffe0e0e0),
    disabledColor: Color(0x61000000),
    highlightColor: Color(0x29000000),
    splashColor: Color(0x1f000000),
    focusColor: Color(0x1f000000),
    hoverColor: Color(0x0a000000),
    colorScheme: ColorScheme(
      primary: Color(0xff59a5be),
      secondary: ColorsApp.purple,
      surface: Color(0xffffffff),
      error: Color(0xffd32f2f),
      onPrimary: Color(0xffffffff),
      onSecondary: ColorsApp.purple,
      onSurface: Color(0xff000000),
      onError: Color(0xffffffff),
      brightness: Brightness.light,
    ),
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      tapTargetSize: MaterialTapTargetSize.padded,
      animationDuration: Duration(milliseconds: 200),
      enableFeedback: true,
      alignment: Alignment.center,
      visualDensity: VisualDensity.standard,
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
      ),
    ),
  ),
  textTheme: const TextTheme(),
  primaryTextTheme: const TextTheme(),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      color: Color(0xdd000000),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    helperStyle: TextStyle(
      color: Color(0xdd000000),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    hintStyle: TextStyle(
      color: Color(0xdd000000),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorStyle: TextStyle(
      color: Color(0xdd000000),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    contentPadding: EdgeInsets.only(top: 12, bottom: 12),
    prefixStyle: TextStyle(
      color: Color(0xdd000000),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    suffixStyle: TextStyle(
      color: Color(0xdd000000),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    counterStyle: TextStyle(
      color: Color(0xdd000000),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    fillColor: Color(0x00000000),
    errorBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
    focusedBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
    disabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
    enabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
    border: UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xdd000000),
    opacity: 1,
    size: 24,
  ),
  primaryIconTheme: const IconThemeData(
    color: Color(0xffffffff),
    opacity: 1,
    size: 24,
  ),
  sliderTheme: const SliderThemeData(
    valueIndicatorTextStyle: TextStyle(
      color: Color(0xffffffff),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: Color(0xffffffff),
    unselectedLabelColor: Color(0xb2ffffff),
  ),
  chipTheme: const ChipThemeData(
    backgroundColor: Color(0x1f000000),
    brightness: Brightness.light,
    deleteIconColor: Color(0xde000000),
    disabledColor: Color(0x0c000000),
    labelPadding: EdgeInsets.only(left: 8, right: 8),
    labelStyle: TextStyle(
      color: Color(0xde000000),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    padding: EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
    secondaryLabelStyle: TextStyle(
      color: Color(0x3d000000),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    secondarySelectedColor: Color(0x3d59a5be),
    selectedColor: Color(0x3d000000),
    shape: StadiumBorder(),
  ),
  dialogTheme: const DialogTheme(
    shape: RoundedRectangleBorder(),
  ),
);

//Build theme data with google fonts
ThemeData buildThemeData() {
  return myTheme.copyWith(
    textTheme: GoogleFonts.poppinsTextTheme(myTheme.textTheme),
    primaryTextTheme: GoogleFonts.poppinsTextTheme(myTheme.primaryTextTheme),
  );
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  EdgeInsets get paddingPages => const EdgeInsets.symmetric(horizontal: 16);
}
