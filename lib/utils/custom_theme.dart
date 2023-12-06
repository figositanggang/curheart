import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color lightPrimary = Color(0xFF7FFFE1);
final Color primaryColor = Color.fromRGBO(0, 191, 145, 1);
final Color darkPrimary = Color(0XFF0046351);
final Color dangerRed = Color(0XFFFD60335);

Color reversedColor(BuildContext context) {
  if (Theme.of(context).brightness == Brightness.dark) {
    return Colors.white;
  }

  return Colors.black;
}

Color directColor(BuildContext context) {
  if (Theme.of(context).brightness == Brightness.dark) {
    return Colors.black;
  }

  return Colors.white;
}

Color reversedPrimary(BuildContext context) {
  if (Theme.of(context).brightness == Brightness.dark) {
    return lightPrimary;
  }

  return darkPrimary;
}

Color directPrimary(BuildContext context) {
  if (Theme.of(context).brightness == Brightness.dark) {
    return darkPrimary;
  }

  return lightPrimary;
}

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: GoogleFonts.poppins().fontFamily,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: primaryColor,
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: GoogleFonts.poppins().fontFamily,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: primaryColor,
  ),
);
