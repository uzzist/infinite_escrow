import 'package:flutter/material.dart';

import '../constants/color_constant.dart';
import '../constants/font_constant.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: FontConstant.jakartaRegular,
  scaffoldBackgroundColor: ColorConstant.white,
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    primary: ColorConstant.midNight,
    secondary: ColorConstant.darkestGrey,
    tertiary: ColorConstant.black,
    outline: ColorConstant.grey,
      primaryContainer: ColorConstant.white
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: ColorConstant.white
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      color: ColorConstant.midNight,
    ),
  ),
);