import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFE4F7EE),
  100: Color(0xFFBBECD5),
  200: Color(0xFF8EDFB9),
  300: Color(0xFF61D29D),
  400: Color(0xFF3FC988),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF1AB96B),
  700: Color(0xFF15B160),
  800: Color(0xFF11A956),
  900: Color(0xFF0A9B43),
});
const int _primaryPrimaryValue = 0xFF1DBF73;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFC9FFDB),
  200: Color(_primaryAccentValue),
  400: Color(0xFF63FF98),
  700: Color(0xFF49FF87),
});
const int _primaryAccentValue = 0xFF96FFBA;
