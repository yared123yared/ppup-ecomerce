// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

import 'package:gigpoint/model/product_details.dart';
import 'package:hive/hive.dart';
part 'products.g.dart';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  Products({
    required this.productByStore,
  });

  final ProductByStore productByStore;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        productByStore: ProductByStore.fromJson(json['productByStore']),
      );

  Map<String, dynamic> toJson() => {
        'productByStore': productByStore.toJson(),
      };
}

class ProductByStore {
  ProductByStore({
    required this.products,
    required this.totalRecords,
  });

  final List<Product> products;
  final int totalRecords;

  factory ProductByStore.fromJson(Map<String, dynamic> json) => ProductByStore(
        products: List<Product>.from(
            json['products'].map((x) => Product.fromJson(x))),
        totalRecords: json['totalRecords'],
      );

  Map<String, dynamic> toJson() => {
        'products': List<dynamic>.from(products.map((x) => x.toJson())),
        'totalRecords': totalRecords,
      };
}

@HiveType(typeId: 0)
class Product {
  Product({
    required this.id,
    required this.name,
    required this.primaryImageHref,
    required this.title,
    this.finalCost,
    required this.variantCount,
    this.brief,
    this.tags,
    this.brandName,
    this.brandTitle,
    this.content,
    this.supplerName,
    this.productParameters,
    this.selectedVariant,
    this.qty = 1,
  });
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String primaryImageHref;
  @HiveField(3)
  final String title;
  @HiveField(4)
  final double? finalCost;
  @HiveField(5)
  final int variantCount;
  @HiveField(6)
  final String? brief;
  @HiveField(7)
  final List<String>? tags;
  @HiveField(8)
  final String? brandName;
  @HiveField(9)
  final String? brandTitle;
  @HiveField(10)
  int qty;
  @HiveField(11)
  final String? content;
  @HiveField(12)
  final String? supplerName;
  @HiveField(13)
  final List<ProductParameter>? productParameters;
  @HiveField(14)
  ProductSkus? selectedVariant;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        primaryImageHref: json['primaryImageHref'],
        title: json['title'],
        finalCost: json['finalCost']?.toDouble(),
        variantCount: json['variantCount'],
        brief: json['brief'],
        tags: List<String>.from(json['tags'].map((x) => x)),
        brandName: json['brandName'],
        brandTitle: json['brandTitle'],
        content: json['content'],
        supplerName: json['supplerName'],
        productParameters: json['productParameters'] == null
            ? []
            : List<ProductParameter>.from(json['productParameters']
                .map((x) => ProductParameter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'primaryImageHref': primaryImageHref,
        'title': title,
        'finalCost': finalCost,
        'variantCount': variantCount,
        'brief': brief,
        'tags': List<dynamic>.from(tags!.map((x) => x)),
        'brandName': brandName,
        'brandTitle': brandTitle,
        'content': content,
        'supplerName': supplerName,
        'productParameters': productParameters == null
            ? null
            : List<dynamic>.from(productParameters!.map((x) => x.toJson())),
      };
}
