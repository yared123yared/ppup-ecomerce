// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductSkusAdapter extends TypeAdapter<ProductSkus> {
  @override
  final int typeId = 3;

  @override
  ProductSkus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductSkus(
      id: fields[0] as String,
      name: fields[1] as String,
      title: fields[2] as String,
      imageHash: fields[3] as String,
      baseCount: fields[4] as int?,
      finalCost: fields[5] as double,
      options: (fields[6] as List).cast<Option>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductSkus obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.imageHash)
      ..writeByte(4)
      ..write(obj.baseCount)
      ..writeByte(5)
      ..write(obj.finalCost)
      ..writeByte(6)
      ..write(obj.options);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductSkusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OptionAdapter extends TypeAdapter<Option> {
  @override
  final int typeId = 6;

  @override
  Option read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Option(
      carrier: fields[0] as String?,
      size: fields[1] as String?,
      color: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Option obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.carrier)
      ..writeByte(1)
      ..write(obj.size)
      ..writeByte(2)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductParameterAdapter extends TypeAdapter<ProductParameter> {
  @override
  final int typeId = 4;

  @override
  ProductParameter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductParameter(
      name: fields[0] as String,
      displayType: fields[11] as String?,
      parameterOptions: (fields[2] as List).cast<ParameterOption>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductParameter obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(11)
      ..write(obj.displayType)
      ..writeByte(2)
      ..write(obj.parameterOptions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductParameterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ParameterOptionAdapter extends TypeAdapter<ParameterOption> {
  @override
  final int typeId = 5;

  @override
  ParameterOption read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParameterOption(
      name: fields[0] as String,
      title: fields[1] as String,
      imageHash: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ParameterOption obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.imageHash);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParameterOptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
