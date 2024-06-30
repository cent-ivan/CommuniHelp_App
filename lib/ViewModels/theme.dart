import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Colors.white, //for backgorund
    outline: Color(0xFF3D424A) //for texts and icons
  )
);

ThemeData darktMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF3D424A), 
    outline: Colors.white70
  )
);