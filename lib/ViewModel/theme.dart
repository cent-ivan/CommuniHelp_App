import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Colors.white, //for backgorund
    primary: Color(0xFFEFEFEF),
    secondary: Color(0xFFF8F8F8), //For extra not important stuff
    outline: Color(0xFF3D424A), //for texts and icons
    surfaceContainer: Color(0xFFF2F2F2) //buttons
  )
);

ThemeData darktMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Color(0xFF31363C), //for backgorund
    primary: Color(0xFF3D424A), 
    secondary: Color(0xFF31373C),
    outline: Color(0xFFEDEDED), //for texts and icons
    surfaceContainer: Color(0xFFADADAD)//buttons
  )
);
