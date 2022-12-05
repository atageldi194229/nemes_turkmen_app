// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TranslationModel {
  final String sentence;
  final String translation;
  final String? audio;

  TranslationModel({
    required this.sentence,
    required this.translation,
    this.audio,
  });

  TranslationModel copyWith({
    String? sentence,
    String? translation,
    String? audio,
  }) {
    return TranslationModel(
      sentence: sentence ?? this.sentence,
      translation: translation ?? this.translation,
      audio: audio ?? this.audio,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sentence': sentence,
      'translation': translation,
      'audio': audio,
    };
  }

  factory TranslationModel.fromMap(Map<String, dynamic> map) {
    return TranslationModel(
      sentence: map['sentence'] as String,
      translation: map['translation'] as String,
      audio: map['audio'] != null ? map['audio'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TranslationModel.fromJson(String source) =>
      TranslationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TranslationModel(sentence: $sentence, translation: $translation, audio: $audio)';

  @override
  bool operator ==(covariant TranslationModel other) {
    if (identical(this, other)) return true;

    return other.sentence == sentence &&
        other.translation == translation &&
        other.audio == audio;
  }

  @override
  int get hashCode => sentence.hashCode ^ translation.hashCode ^ audio.hashCode;
}
