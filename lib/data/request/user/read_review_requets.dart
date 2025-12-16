import 'package:json_annotation/json_annotation.dart';

part 'read_review_requets.g.dart';

@JsonSerializable()
class ReadReviewRequets {
  final int id;
  final bool isRead;
  ReadReviewRequets({required this.id, required this.isRead});

  factory ReadReviewRequets.fromJson(Map<String, dynamic> json) =>
      _$ReadReviewRequetsFromJson(json);
  Map<String, dynamic> toJson() => _$ReadReviewRequetsToJson(this);
}
