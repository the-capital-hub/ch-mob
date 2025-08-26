// To parse this JSON data, do
//
//     final getMeetingsModel = getMeetingsModelFromJson(jsonString);

import 'dart:convert';

GetMeetingsModel getMeetingsModelFromJson(String str) =>
    GetMeetingsModel.fromJson(json.decode(str));

String getMeetingsModelToJson(GetMeetingsModel data) =>
    json.encode(data.toJson());

class GetMeetingsModel {
  bool status;
  String message;
  List<Meeting> data;

  GetMeetingsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetMeetingsModel.fromJson(Map<String, dynamic> json) =>
      GetMeetingsModel(
        status: json["status"],
        message: json["message"],
        data: List<Meeting>.from(json["data"].map((x) => Meeting.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Meeting {
  String id;
  String title;
  String name;
  String? userProfile;
  String email;
  String paymentAmount;
  String description;
  String startTime;
  String endTime;
  String? meetingLink;
  String duration;

  Meeting({
    required this.id,
    required this.title,
    required this.name,
    required this.email,
    this.userProfile,
    required this.paymentAmount,
    required this.description,
    required this.startTime,
    required this.endTime,
    this.meetingLink,
    required this.duration,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
        id: json["_id"],
        title: json["title"],
        name: json["name"],
        userProfile: json['userProfile'],
        email: json["email"],
        paymentAmount: json["paymentAmount"],
        description: json["description"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        meetingLink: json["meetingLink"] ?? "",
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "name": name,
        "email": email,
        "paymentAmount": paymentAmount,
        "description": description,
        "startTime": startTime,
        "endTime": endTime,
        "meetingLink": meetingLink,
        "duration": duration,
      };
}
