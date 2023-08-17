import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF000000);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    primaryColor: Colors.teal,
    backgroundColor: Colors.white,
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    primaryColor: Colors.teal,
    backgroundColor: Colors.black,
    brightness: Brightness.dark,
  );

  TextStyle get titleButton {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  TextStyle get title {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.white : darkGreyClr,
      ),
    );
  }

  TextStyle get hintTitle {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 17,
        letterSpacing: 1,
        color: Get.isDarkMode ? Colors.grey[500] : Colors.grey[800],
      ),
    );
  }

  TextStyle get styleInField {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 16,
        color: Get.isDarkMode ? Colors.white : darkGreyClr,
      ),
    );
  }

  TextStyle get styleTextAdd {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w900,
        color: Get.isDarkMode ? Colors.white : darkGreyClr,
      ),
    );
  }

  TextStyle get topTitle {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w900,
        color: Get.isDarkMode ? Colors.white : darkGreyClr,
      ),
    );
  }
  TextStyle get subTitle {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w900,
        color: Get.isDarkMode ? Colors.white : darkGreyClr,
      ),
    );
  }
}
