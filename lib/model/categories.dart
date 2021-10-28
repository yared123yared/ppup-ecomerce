// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

Categories categoriesFromJson(String str) =>
    Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
  Categories({
    required this.categoriesByStore,
  });

  final CategoriesByStore categoriesByStore;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        categoriesByStore:
            CategoriesByStore.fromJson(json['categoriesByStore']),
      );

  Map<String, dynamic> toJson() => {
        'categoriesByStore': categoriesByStore.toJson(),
      };
}

class CategoriesByStore {
  CategoriesByStore({
    required this.categories,
    required this.totalRecords,
  });

  final List<Category> categories;
  final dynamic totalRecords;

  factory CategoriesByStore.fromJson(Map<String, dynamic> json) =>
      CategoriesByStore(
        categories: List<Category>.from(
            json['categories'].map((x) => Category.fromJson(x))),
        totalRecords: json['totalRecords'],
      );

  Map<String, dynamic> toJson() => {
        'categories': List<dynamic>.from(categories.map((x) => x.toJson())),
        'totalRecords': totalRecords,
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.title,
    this.mainImageHash,
    this.notes,
  });

  final String id;
  final String name;
  final String title;
  final String? mainImageHash;
  final String? notes;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json['name'],
        title: json['title'],
        mainImageHash: json['mainImageHash'],
        notes: json['notes'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'title': title,
        'mainImageHash': mainImageHash,
        'notes': notes,
      };
}
