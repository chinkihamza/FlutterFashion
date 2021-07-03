import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  static const logo = const TextStyle(
      fontFamily: "Rancho",
      color: Color(0xFF8071F2),
      letterSpacing: .8,
      fontWeight: FontWeight.bold,
      fontSize: 36);

  static const boldHeading = const TextStyle(
      fontFamily: "Poppins",
      color: Colors.black,
      fontSize: 24,
      letterSpacing: -1.3,
      fontWeight: FontWeight.w300);

  static const regularDarkText = const TextStyle(
      fontFamily: "FiraSansCondensed",
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold);

  static const regularText = const TextStyle(
      fontFamily: "FiraSansCondensed",
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w300);

  static const regularWhiteText = const TextStyle(
      fontFamily: "FiraSansCondensed",
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w300);

  static const regularWhiteHeading = const TextStyle(
      fontFamily: "Poppins",
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w800);
}
