import 'package:flutter/material.dart';
import 'package:infinite_escrow/constants/color_constant.dart';

import '../constants/font_constant.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: FontConstant.jakartaRegular,
  scaffoldBackgroundColor: ColorConstant.black,
    colorScheme: ColorScheme.light(
      brightness: Brightness.dark,
      primary: ColorConstant.white,
      secondary: ColorConstant.offWhite,
      tertiary: ColorConstant.white,
      outline: ColorConstant.offWhite,
      primaryContainer: ColorConstant.grey
    ),
  appBarTheme: AppBarTheme(
      backgroundColor: ColorConstant.black,
  ),
    textTheme: TextTheme(
        displaySmall: TextStyle(
            color: ColorConstant.white,
        )
    )

);