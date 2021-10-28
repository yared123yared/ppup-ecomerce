// To parse this JSON data, do
//
//     final productDetails = productDetailsFromJson(jsonString);

import 'dart:convert';

import 'package:gigpoint/model/products.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'product_details.g.dart';

ProductDetails productDetailsFromJson(String str) =>
    ProductDetails.fromJson(json.decode(str));

String productDetailsToJson(ProductDetails data) => json.encode(data.toJson());

class ProductDetails {
  ProductDetails({
    required this.productDetails,
  });

  final ProductDetailsClass productDetails;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        productDetails: ProductDetailsClass.fromJson(json['productDetails']),
      );

  Map<String, dynamic> toJson() => {
        'productDetails': productDetails.toJson(),
      };
}

class ProductDetailsClass {
  ProductDetailsClass({
    required this.products,
    required this.productSkus,
    this.selectedVariant,
    this.qty = 1,
  });

  final Product products;
  final List<ProductSkus> productSkus;
  String? selectedVariant;
  int qty;

  factory ProductDetailsClass.fromJson(Map<String, dynamic> json) =>
      ProductDetailsClass(
        products: Product.fromJson(json['products']),
        productSkus: List<ProductSkus>.from(
            json['productSkus'].map((x) => ProductSkus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'products': products.toJson(),
        'productSkus': List<dynamic>.from(productSkus.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 3)
class ProductSkus {
  ProductSkus({
    required this.id,
    required this.name,
    required this.title,
    required this.imageHash,
    this.baseCount,
    required this.finalCost,
    required this.options,
  });
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String imageHash;
  @HiveField(4)
  final int? baseCount;
  @HiveField(5)
  final double finalCost;
  @HiveField(6)
  final List<Option> options;

  factory ProductSkus.fromJson(Map<String, dynamic> json) => ProductSkus(
        id: json['id'],
        name: json['name'],
        title: json['title'],
        imageHash: json['imageHash'],
        baseCount: json['baseCount'],
        finalCost: json['finalCost'].toDouble(),
        options:
            List<Option>.from(json['options'].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'title': title,
        'imageHash': imageHash,
        'baseCount': baseCount,
        'finalCost': finalCost,
        'options': List<dynamic>.from(options.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 6)
class Option {
  Option({
    this.carrier,
    this.size,
    this.color,
  });
  @HiveField(0)
  final String? carrier;
  @HiveField(1)
  final String? size;
  @HiveField(2)
  final String? color;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        carrier: json['Carrier'],
        size: json['Size'],
        color: json['Color'],
      );

  Map<String, dynamic> toJson() => {
        'Carrier': carrier,
        'Size': size,
        'Color': color,
      };
}

@HiveType(typeId: 4)
class ProductParameter {
  ProductParameter({
    required this.name,
    this.displayType,
    required this.parameterOptions,
  });
  @HiveField(0)
  final String name;
  @HiveField(11)
  final String? displayType;
  @HiveField(2)
  final List<ParameterOption> parameterOptions;

  factory ProductParameter.fromJson(Map<String, dynamic> json) =>
      ProductParameter(
        name: json['name'],
        displayType: json['displayType'],
        parameterOptions: List<ParameterOption>.from(
            json['parameterOptions'].map((x) => ParameterOption.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'displayType': displayType,
        'parameterOptions':
            List<dynamic>.from(parameterOptions.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 5)
class ParameterOption {
  ParameterOption({
    required this.name,
    required this.title,
    required this.imageHash,
  });

  @HiveField(0)
  final String name;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String imageHash;

  factory ParameterOption.fromJson(Map<String, dynamic> json) =>
      ParameterOption(
        name: json['name'],
        title: json['title'],
        imageHash: json['imageHash'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'title': title,
        'imageHash': imageHash,
      };
}
