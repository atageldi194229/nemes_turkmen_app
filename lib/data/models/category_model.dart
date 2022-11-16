import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:nemes/data/models/translation_model.dart';

class CategoryModel {
  final String name;
  final List<TranslationModel> translations;

  CategoryModel({
    required this.name,
    required this.translations,
  });

  CategoryModel copyWith({
    String? name,
    List<TranslationModel>? translations,
  }) {
    return CategoryModel(
      name: name ?? this.name,
      translations: translations ?? this.translations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'translations': translations.map((x) => x.toMap()).toList(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'] as String,
      translations: List<TranslationModel>.from(
        (map['translations'] as List<dynamic>).map<TranslationModel>(
          (x) => TranslationModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CategoryModel(name: $name, translations: $translations)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.name == name && listEquals(other.translations, translations);
  }

  @override
  int get hashCode => name.hashCode ^ translations.hashCode;
}
