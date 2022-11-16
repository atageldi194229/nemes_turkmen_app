import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:nemes/data/models/category_model.dart';

class AppDataModel {
  final List<CategoryModel> categories;
  AppDataModel({
    required this.categories,
  });

  AppDataModel copyWith({
    List<CategoryModel>? categories,
  }) {
    return AppDataModel(
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categories': categories.map((x) => x.toMap()).toList(),
    };
  }

  factory AppDataModel.fromMap(Map<String, dynamic> map) {
    return AppDataModel(
      categories: List<CategoryModel>.from(
        (map['categories'] as List<dynamic>).map<CategoryModel>(
          (x) => CategoryModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppDataModel.fromJson(String source) =>
      AppDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AppDataModel(categories: $categories)';

  @override
  bool operator ==(covariant AppDataModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.categories, categories);
  }

  @override
  int get hashCode => categories.hashCode;
}
