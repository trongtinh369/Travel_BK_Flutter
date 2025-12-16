import 'package:json_annotation/json_annotation.dart';

part 'check_account_request.g.dart';

@JsonSerializable()
class CheckAccountRequest {
  String email;

  CheckAccountRequest({
    required this.email,
  });

  Map<String, dynamic> toJson() => _$CheckAccountRequestToJson(this);
}
