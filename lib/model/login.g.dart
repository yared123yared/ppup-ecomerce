// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginClassAdapter extends TypeAdapter<LoginClass> {
  @override
  final int typeId = 1;

  @override
  LoginClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginClass(
      id: fields[0] as int?,
      accessToken: fields[1] as String?,
      tokenType: fields[2] as String?,
      expiresIn: fields[3] as int?,
      refreshToken: fields[4] as String?,
      userRoles: (fields[5] as List?)?.cast<String>(),
      message: fields[6] as String,
      statusCode: fields[7] as int,
      termsAndConditionsAccepted: fields[9] as bool?,
      firstTimeBonus: fields[10] as double?,
      isFirstTime: fields[11] as bool?,
      firstName: fields[12] as String?,
      lastName: fields[13] as String?,
      email: fields[14] as String?,
      phone: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LoginClass obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.accessToken)
      ..writeByte(2)
      ..write(obj.tokenType)
      ..writeByte(3)
      ..write(obj.expiresIn)
      ..writeByte(4)
      ..write(obj.refreshToken)
      ..writeByte(5)
      ..write(obj.userRoles)
      ..writeByte(6)
      ..write(obj.message)
      ..writeByte(7)
      ..write(obj.statusCode)
      ..writeByte(8)
      ..write(obj.phone)
      ..writeByte(9)
      ..write(obj.termsAndConditionsAccepted)
      ..writeByte(10)
      ..write(obj.firstTimeBonus)
      ..writeByte(11)
      ..write(obj.isFirstTime)
      ..writeByte(12)
      ..write(obj.firstName)
      ..writeByte(13)
      ..write(obj.lastName)
      ..writeByte(14)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
