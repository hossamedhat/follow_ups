
import 'package:flutter/material.dart';

class ThemeBasic {
  const ThemeBasic._();

  static final ThemeData baseLight = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      brightness: Brightness.light,
    ),
    iconTheme: IconThemeData(
      color: Colors.blueAccent,
    ),
    useMaterial3: true,
  );

  static final ThemeData baseDark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      brightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(
      color: Colors.blueAccent,
    ),
    useMaterial3: true,
  );
}
