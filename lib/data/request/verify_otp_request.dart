// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_request.g.dart';

@JsonSerializable()
class VerifyOtpRequest {
  String email;
  String code;

  VerifyOtpRequest({
    required this.email,
    required this.code,
  });
  
  Map<String, dynamic> toJson() => _$VerifyOtpRequestToJson(this);
}
