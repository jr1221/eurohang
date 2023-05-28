import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable(createToJson: false)
class Question {
  int id;
  String guess;

  Uri moreInfo;

  Question({
    required this.id,
    required this.guess,
    required this.moreInfo,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  @override
  toString() => 'Q$id: $guess --> More info URL: $moreInfo';
}
