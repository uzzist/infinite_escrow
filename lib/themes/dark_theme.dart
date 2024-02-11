import 'package:flutter/material.dart';

import '../constants/font_constant.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: FontConstant.jakartaRegular,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Colors.grey[900]!,
    secondary: Colors.grey[800]!,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: Colors.white,
    )
  )
);