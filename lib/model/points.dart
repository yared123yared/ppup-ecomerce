// To parse this JSON data, do
//
//     final points = pointsFromJson(jsonString);

import 'dart:convert';

Points pointsFromJson(String str) => Points.fromJson(json.decode(str));

String pointsToJson(Points data) => json.encode(data.toJson());

class Points {
  Points({
    required this.points,
  });

  final Reward points;

  factory Points.fromJson(Map<String, dynamic> json) => Points(
        points: Reward.fromJson(json['points']),
      );

  Map<String, dynamic> toJson() => {
        'points': points.toJson(),
      };
}

class Reward {
  Reward({
    required this.pointsTransactions,
    required this.totalRecords,
  });

  final List<PointsTransaction> pointsTransactions;
  final int totalRecords;

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        pointsTransactions: List<PointsTransaction>.from(
            json['pointsTransactions']
                .map((x) => PointsTransaction.fromJson(x))),
        totalRecords: json['totalRecords'],
      );

  Map<String, dynamic> toJson() => {
        'pointsTransactions':
            List<dynamic>.from(pointsTransactions.map((x) => x.toJson())),
        'totalRecords': totalRecords,
      };
}

class PointsTransaction {
  PointsTransaction({
    this.id,
    this.date,
    this.numPoints,
    this.description,
  });

  final int? id;
  final DateTime? date;
  final double? numPoints;
  final String? description;

  factory PointsTransaction.fromJson(Map<String, dynamic> json) =>
      PointsTransaction(
        id: json['id'],
        date: DateTime.parse(json['date']),
        numPoints: json['numPoints'].toDouble(),
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date!.toIso8601String(),
        'numPoints': numPoints,
        'description': description,
      };
}
