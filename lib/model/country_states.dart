// To parse this JSON data, do
//
//     final stateList = stateListFromJson(jsonString);

import 'dart:convert';

CountryStates stateListFromJson(String str) =>
    CountryStates.fromJson(json.decode(str));

String stateListToJson(CountryStates data) => json.encode(data.toJson());

class CountryStates {
  CountryStates({
    this.statesList,
  });

  final List<StatesList>? statesList;

  factory CountryStates.fromJson(Map<String, dynamic> json) => CountryStates(
        statesList: List<StatesList>.from(
            json['statesList'].map((x) => StatesList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'statesList': List<dynamic>.from(statesList!.map((x) => x.toJson())),
      };
}

class StatesList {
  StatesList({
    this.stateCode,
    this.stateName,
  });

  final String? stateCode;
  final String? stateName;

  factory StatesList.fromJson(Map<String, dynamic> json) => StatesList(
        stateCode: json['stateCode'],
        stateName: json['stateName'],
      );

  Map<String, dynamic> toJson() => {
        'stateCode': stateCode,
        'stateName': stateName,
      };
}
