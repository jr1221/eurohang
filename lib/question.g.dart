// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: json['id'] as int,
      guess: json['guess'] as String,
      moreInfo: Uri.parse(json['moreInfo'] as String),
      partPaths: _$recordConvert(
        json['partPaths'],
        ($jsonValue) => (
          part3: $jsonValue['part3'] as String,
          part4: $jsonValue['part4'] as String,
          part5: $jsonValue['part5'] as String,
          part6: $jsonValue['part6'] as String,
        ),
      ),
    );

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);
