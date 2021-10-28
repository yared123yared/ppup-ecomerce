// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      id: fields[0] as String,
      name: fields[1] as String,
      primaryImageHref: fields[2] as String,
      title: fields[3] as String,
      finalCost: fields[4] as double?,
      variantCount: fields[5] as int,
      brief: fields[6] as String?,
      tags: (fields[7] as List?)?.cast<String>(),
      brandName: fields[8] as String?,
      brandTitle: fields[9] as String?,
      content: fields[11] as String?,
      supplerName: fields[12] as String?,
      productParameters: (fields[13] as List?)?.cast<ProductParameter>(),
      selectedVariant: fields[14] as ProductSkus?,
      qty: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.primaryImageHref)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.finalCost)
      ..writeByte(5)
      ..write(obj.variantCount)
      ..writeByte(6)
      ..write(obj.brief)
      ..writeByte(7)
      ..write(obj.tags)
      ..writeByte(8)
      ..write(obj.brandName)
      ..writeByte(9)
      ..write(obj.brandTitle)
      ..writeByte(10)
      ..write(obj.qty)
      ..writeByte(11)
      ..write(obj.content)
      ..writeByte(12)
      ..write(obj.supplerName)
      ..writeByte(13)
      ..write(obj.productParameters)
      ..writeByte(14)
      ..write(obj.selectedVariant);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
