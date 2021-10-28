// To parse this JSON data, do
//
//     final contactUs = contactUsFromJson(jsonString);

import 'dart:convert';

ContactUs contactUsFromJson(String str) => ContactUs.fromJson(json.decode(str));

String contactUsToJson(ContactUs data) => json.encode(data.toJson());

class ContactUs {
  ContactUs({
    this.contactUsList,
  });

  final List<ContactUsList>? contactUsList;

  factory ContactUs.fromJson(Map<String, dynamic> json) => ContactUs(
        contactUsList: List<ContactUsList>.from(
            json['contactUsList'].map((x) => ContactUsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'contactUsList':
            List<dynamic>.from(contactUsList!.map((x) => x.toJson())),
      };
}

class ContactUsList {
  ContactUsList({
    this.id,
    this.category,
    this.email,
    this.phone,
  });

  final int? id;
  final String? category;
  final String? email;
  final String? phone;

  factory ContactUsList.fromJson(Map<String, dynamic> json) => ContactUsList(
        id: json['id'],
        category: json['category'],
        email: json['email'],
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'category': category,
        'email': email,
        'phone': phone,
      };
}
