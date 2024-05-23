import "package:flutter/material.dart";

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Colors.white,
    brightness: Brightness.light,
    primary: Colors.deepOrangeAccent,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: Color.fromRGBO(15, 15, 15, 1),
    brightness: Brightness.dark,
    primary: Colors.deepOrangeAccent,
  ),
);
