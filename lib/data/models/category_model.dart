// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:nemes/data/models/translation_model.dart';

class CategoryModel {
  final String name;
  final List<TranslationModel> translations;
  final String image;

  CategoryModel({
    required this.name,
    required this.translations,
    required this.image,
  });

  CategoryModel copyWith({
    String? name,
    List<TranslationModel>? translations,
    String? image,
  }) {
    return CategoryModel(
      name: name ?? this.name,
      translations: translations ?? this.translations,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'translations': translations.map((x) => x.toMap()).toList(),
      'image': image,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'] as String,
      translations: List<TranslationModel>.from(
        (map['translations'] as List).map<TranslationModel>(
          (x) => TranslationModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CategoryModel(name: $name, translations: $translations, image: $image)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        listEquals(other.translations, translations) &&
        other.image == image;
  }

  @override
  int get hashCode => name.hashCode ^ translations.hashCode ^ image.hashCode;
}
