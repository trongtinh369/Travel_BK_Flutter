import 'package:booking_tour_flutter/domain/activity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_response.g.dart';

// @JsonSerializable()
// class ActivityResponse {
//   final List<ActivityResponseData>? data;

//   ActivityResponse({this.data});

//   factory ActivityResponse.fromJson(Map<String, dynamic> json) =>
//       _$ActivityResponseFromJson(json);
// }

@JsonSerializable()
class ActivityResponseData {
  final int? id;
  final String? action;

  ActivityResponseData({this.id, this.action});

  factory ActivityResponseData.fromJson(Map<String, dynamic> json) =>
      _$ActivityResponseDataFromJson(json);
}

// extension ActivityResponseMap on ActivityResponse {
//   List<Activity> map() {
//     var list = data?.map((i) => i.map()).toList() ?? [];
//     return list;
//   }
// }

extension ActivityResponseDataMap on ActivityResponseData {
  Activity map() {
    return Activity(id: id ?? 0, action: action ?? "");
  }
}
