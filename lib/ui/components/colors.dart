import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kPrimaryColor = Colors.white;
const kPrimaryLightcolor = Colors.grey;
const kSecondaryColor = Colors.black;
const kSecondaryLightColor = Color.fromRGBO(255, 87, 34, 1);

class Styles {
  static final darkTheme = ThemeData(
      secondaryHeaderColor: Colors.white,
      fontFamily: GoogleFonts.nunito().fontFamily,
      primaryColor: Colors.black,
      primaryColorDark: const Color(0xFF2C3850),
      primaryColorLight: kPrimaryLightcolor);

  static final lightTheme = ThemeData(
      fontFamily: GoogleFonts.nunito().fontFamily,
      primaryColorLight: kPrimaryLightcolor,
      primaryColor: const Color(0xFFF3F3F3),
      secondaryHeaderColor: kSecondaryColor,
      indicatorColor: kSecondaryLightColor,
      primaryColorDark: Colors.white);
}
