// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: json['id'] as int,
      guess: json['guess'] as String,
      moreInfo: Uri.parse(json['moreInfo'] as String),
    );
