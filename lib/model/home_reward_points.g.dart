// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_reward_points.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RewardsSummaryAdapter extends TypeAdapter<RewardsSummary> {
  @override
  final int typeId = 2;

  @override
  RewardsSummary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RewardsSummary(
      pointsTransactions: (fields[0] as List?)?.cast<PointsTransaction>(),
      isFirstTimeUser: fields[1] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, RewardsSummary obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.pointsTransactions)
      ..writeByte(1)
      ..write(obj.isFirstTimeUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RewardsSummaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PointsTransactionAdapter extends TypeAdapter<PointsTransaction> {
  @override
  final int typeId = 7;

  @override
  PointsTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PointsTransaction(
      date: fields[0] as DateTime?,
      numPoints: fields[1] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, PointsTransaction obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.numPoints);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PointsTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
