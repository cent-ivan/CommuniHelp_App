import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Colors.white, //for backgorund
    primary: Color(0xFFF2F2F2),
    secondary: Color(0xFFF5F5F5), //For extra not important stuff
    outline: Color(0xFF3D424A) //for texts and icons
  )
);

ThemeData darktMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF31363C), //for backgorund
    primary: Color(0xFF3D424A), 
    secondary: Color(0xFF31373C),
    outline: Color(0xFFFAFAFA) //for texts and icons
  )
);