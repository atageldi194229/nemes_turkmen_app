import 'dart:convert';

class TranslationModel {
  final String sentence;
  final String translation;

  TranslationModel({
    required this.sentence,
    required this.translation,
  });

  TranslationModel copyWith({
    String? sentence,
    String? translation,
  }) {
    return TranslationModel(
      sentence: sentence ?? this.sentence,
      translation: translation ?? this.translation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sentence': sentence,
      'translation': translation,
    };
  }

  factory TranslationModel.fromMap(Map<String, dynamic> map) {
    return TranslationModel(
      sentence: map['sentence'] as String,
      translation: map['translation'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TranslationModel.fromJson(String source) =>
      TranslationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Translation(sentence: $sentence, translation: $translation)';

  @override
  bool operator ==(covariant TranslationModel other) {
    if (identical(this, other)) return true;

    return other.sentence == sentence && other.translation == translation;
  }

  @override
  int get hashCode => sentence.hashCode ^ translation.hashCode;
}
