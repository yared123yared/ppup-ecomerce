// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
part 'login.g.dart';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    required this.login,
  });

  final LoginClass login;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        login: LoginClass.fromJson(json['login']),
      );

  Map<String, dynamic> toJson() => {
        'login': login.toJson(),
      };
}

@HiveType(typeId: 1)
class LoginClass {
  LoginClass({
    this.id,
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.refreshToken,
    this.userRoles,
    required this.message,
    required this.statusCode,
    this.termsAndConditionsAccepted,
    this.firstTimeBonus,
    this.isFirstTime = false,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
  });

  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? accessToken;
  @HiveField(2)
  final String? tokenType;
  @HiveField(3)
  final int? expiresIn;
  @HiveField(4)
  final String? refreshToken;
  @HiveField(5)
  final List<String>? userRoles;
  @HiveField(6)
  final String message;
  @HiveField(7)
  final int statusCode;
  @HiveField(8)
  final String? phone;
  @HiveField(9)
  bool? termsAndConditionsAccepted;
  @HiveField(10)
  double? firstTimeBonus;
  @HiveField(11)
  bool? isFirstTime;
  @HiveField(12)
  final String? firstName;
  @HiveField(13)
  final String? lastName;
  @HiveField(14)
  final String? email;

  factory LoginClass.fromJson(Map<String, dynamic> json) => LoginClass(
        id: json['id'],
        accessToken: json['accessToken'],
        tokenType: json['tokenType'],
        expiresIn: json['expiresIn'],
        refreshToken: json['refreshToken'],
        userRoles: json['userRoles'] == null
            ? []
            : List<String>.from(json['userRoles'].map((x) => x)),
        message: json['message'],
        statusCode: json['statusCode'],
        termsAndConditionsAccepted: json['termsAndConditionsAccepted'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'accessToken': accessToken,
        'tokenType': tokenType,
        'expiresIn': expiresIn,
        'refreshToken': refreshToken,
        'userRoles': List<dynamic>.from(userRoles!.map((x) => x)),
        'message': message,
        'statusCode': statusCode,
        'termsAndConditionsAccepted': termsAndConditionsAccepted,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
      };
}
