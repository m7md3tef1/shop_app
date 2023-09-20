import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  primaryColor: Colors.white,
  brightness: Brightness.dark,
  dividerColor: Colors.black12,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
      .copyWith(background: const Color(0xFF212121))
      .copyWith(secondary: Colors.red),
);
ThemeData lightMode = ThemeData(
  primaryColor: Colors.white,
  brightness: Brightness.light,
  dividerColor: Colors.white54,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
      .copyWith(background: const Color(0xFFE5E5E5))
      .copyWith(secondary: Colors.black),
);
