import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'constants.dart';

class Styles {
  ///Font weight 400
  static TextStyle regular(
          {required double fontSize,
          Color color = AppTheme.textPrimaryColor,
          double letterSpacing = 0}) =>
      TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: fontSize,
          fontFamily: Constants.fontFamily,
          letterSpacing: letterSpacing,
          color: color);

  ///Font weight 600
  static TextStyle semiBold(
          {required double fontSize,
          Color color = AppTheme.textPrimaryColor,
          double letterSpacing = 0}) =>
      TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
          fontFamily: Constants.fontFamily,
          letterSpacing: letterSpacing,
          color: color);

  ///Font weight 700
  static TextStyle bold(
          {required double fontSize,
          Color color = AppTheme.textPrimaryColor,
          double letterSpacing = 0}) =>
      TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
          fontFamily: Constants.fontFamily,
          letterSpacing: letterSpacing,
          color: color);
}
