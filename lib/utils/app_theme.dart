import 'package:flutter/material.dart';

class AppTheme {
  static const primaryColor = Color.fromRGBO(232, 119, 34, 1);
  static const primaryLightColor = Color.fromRGBO(255, 226, 204, 1);
  static const textPrimaryColor = Colors.black;
  static const textSecondaryColor = Color.fromRGBO(0, 0, 0, 0.5);
  static const borderColor = Color.fromRGBO(224, 224, 224, 1);
  static const disabledColor = Color(0xffcacaca);
  static const scaffoldBackground = Color.fromRGBO(245, 245, 245, 1);
  static const cardBackgroundColor = Color.fromRGBO(255, 255, 255, 1);
  static const greenColor = Color.fromRGBO(52, 199, 89, 1);
  static const redColor = Color.fromRGBO(255, 69, 58, 1);
  static const errorColor = Color(0xffff2300);
  static const List<BoxShadow> boxShadow = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.3),
      spreadRadius: 0,
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ];
}
