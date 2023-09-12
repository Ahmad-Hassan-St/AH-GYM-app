
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

TextStyle kAppBarTextStyle=const TextStyle(
    fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Roboto');

TextStyle kDescriptionSubHeading=const TextStyle(
  color: Colors.grey,
  fontSize: 20,
  fontWeight: FontWeight.bold,

);
TextStyle kDescriptionHeading=GoogleFonts.poppins(
  fontSize: 25,
  fontWeight: FontWeight.w600,
);

TextStyle kToDoList=GoogleFonts.inter(
  fontSize: 16,
  fontWeight: FontWeight.w400,
);
TextStyle kLoginStyle= TextStyle(
    fontSize: 15,
    color: kSecondaryColor,
    fontWeight: FontWeight.bold);

TextStyle kForgetPassword=TextStyle(
  color: kSecondaryColor,
  letterSpacing: 0.5,
  fontSize: 22,
  fontWeight: FontWeight.bold,
);
TextStyle kHomeStore= TextStyle(
  fontSize: 28,
  color: kSecondaryColor,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.2,
);
TextStyle kHomeTitle=TextStyle(
  color: kThirdColor,
  fontWeight: FontWeight.w600,
  fontSize: 24,
  decoration: TextDecoration.none,
);
TextStyle kSignUp=TextStyle(
    color: kSecondaryColor,
    fontWeight: FontWeight.bold,
    fontSize: 15);
TextStyle kAccountStyle=TextStyle(color: kSecondaryColor);
TextStyle kNumberStyle=TextStyle(
  color: kSecondaryColor,
  letterSpacing: 1.1,
  fontSize: 22,
  fontWeight: FontWeight.bold,
);