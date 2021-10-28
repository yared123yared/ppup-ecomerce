// To parse this JSON data, do
//
//     final address = addressFromJson(jsonString);

import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    this.addressList,
  });

  final List<AddressList>? addressList;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressList: List<AddressList>.from(
            json['addressList'].map((x) => AddressList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'addressList': List<dynamic>.from(addressList!.map((x) => x.toJson())),
      };
}

class AddressList {
  AddressList({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.phone,
    this.addressLine,
    this.addressLine2,
    this.city,
    this.state,
    this.country,
    this.zipcode,
    this.addressType,
  });

  int? id;
  int? userId;
  String? firstName;
  String? lastName;
  String? phone;
  String? addressLine;
  String? addressLine2;
  String? city;
  String? state;
  String? country;
  String? zipcode;
  String? addressType;

  factory AddressList.fromJson(Map<String, dynamic> json) => AddressList(
        id: json['id'],
        userId: json['userId'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        phone: json['phone'],
        addressLine: json['addressLine'],
        addressLine2: json['addressLine2'],
        city: json['city'],
        state: json['state'],
        country: json['country'],
        zipcode: json['zipcode'],
        addressType: json['addressType'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'addressLine': addressLine,
        'addressLine2': addressLine2,
        'city': city,
        'state': state,
        'country': country,
        'zipcode': zipcode,
        'addressType': addressType,
      };
}
