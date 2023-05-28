import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable(createToJson: false)
class Question {
  int id;
  String guess;

  Uri moreInfo;

  ({String part3, String part4, String part5, String part6}) partPaths;

  Question(
      {required this.id,
      required this.guess,
      required this.moreInfo,
      required this.partPaths});

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  @override
  toString() => 'Q$id: $guess --> More info URL: $moreInfo';
}
