import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Colors.white, //for backgorund
    primary: Color(0xFFF2F2F2),
    outline: Color(0xFF3D424A) //for texts and icons
  )
);

ThemeData darktMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF31363C), //for backgorund
    primary: Color(0xFF3D424A), 
    outline: Colors.white70 //for texts and icons
  )
);