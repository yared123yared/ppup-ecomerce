// To parse this JSON data, do
//
//     final homeRewardPoints = homeRewardPointsFromJson(jsonString);

import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
part 'home_reward_points.g.dart';

HomeRewardPoints homeRewardPointsFromJson(String str) =>
    HomeRewardPoints.fromJson(json.decode(str));

String homeRewardPointsToJson(HomeRewardPoints data) =>
    json.encode(data.toJson());

class HomeRewardPoints {
  HomeRewardPoints({
    this.rewardsSummary,
  });

  final RewardsSummary? rewardsSummary;

  factory HomeRewardPoints.fromJson(Map<String, dynamic> json) =>
      HomeRewardPoints(
        rewardsSummary: RewardsSummary.fromJson(json['rewardsSummary']),
      );

  Map<String, dynamic> toJson() => {
        'rewardsSummary': rewardsSummary!.toJson(),
      };
}

@HiveType(typeId: 2)
class RewardsSummary {
  RewardsSummary({
    this.pointsTransactions,
    this.totalPoints,
    this.isFirstTimeUser,
  });
  @HiveField(0)
  final List<PointsTransaction>? pointsTransactions;
  final double? totalPoints;
  @HiveField(1)
  final bool? isFirstTimeUser;
  @HiveField(2)
  factory RewardsSummary.fromJson(Map<String, dynamic> json) => RewardsSummary(
        pointsTransactions: List<PointsTransaction>.from(
            json['pointsTransactions']
                .map((x) => PointsTransaction.fromJson(x))),
        totalPoints:
            json['totalPoints'] == null ? 0.0 : json['totalPoints'].toDouble(),
        isFirstTimeUser: json['isFirstTimeUser'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'pointsTransactions':
            List<dynamic>.from(pointsTransactions!.map((x) => x.toJson())),
        'totalPoints': totalPoints,
        'isFirstTimeUser': isFirstTimeUser,
      };
}

@HiveType(typeId: 7)
class PointsTransaction {
  PointsTransaction({
    this.date,
    this.numPoints,
  });
  @HiveField(0)
  final DateTime? date;
  @HiveField(1)
  final double? numPoints;

  factory PointsTransaction.fromJson(Map<String, dynamic> json) =>
      PointsTransaction(
        date: DateTime.parse(json['date']),
        numPoints: json['numPoints'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'date':
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        'numPoints': numPoints,
      };
}
