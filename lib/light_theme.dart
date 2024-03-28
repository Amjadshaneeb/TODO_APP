import 'package:flutter/material.dart';

ThemeData lightmode =ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background:Color.fromARGB(255, 45, 92, 233),
    primary: Color.fromARGB(213, 0, 0, 0),
    secondary: Color.fromARGB(255, 58, 58, 58),
    tertiary: Colors.red

  )
);

ThemeData darkmode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: const Color.fromARGB(249, 0, 0, 0),
    secondary: Colors.grey.shade800,
  )
);