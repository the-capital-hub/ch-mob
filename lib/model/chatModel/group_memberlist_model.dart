// To parse this JSON data, do
//
//     final createChatModel = createChatModelFromJson(jsonString);

import 'dart:convert';

GroupMemberListModel createChatModelFromJson(String str) =>
    GroupMemberListModel.fromJson(json.decode(str));

String createChatModelToJson(GroupMemberListModel data) =>
    json.encode(data.toJson());

class GroupMemberListModel {
  bool status;
  String message;
  List<Groups> data;

  GroupMemberListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GroupMemberListModel.fromJson(Map<String, dynamic> json) =>
      GroupMemberListModel(
        status: json["status"],
        message: json["message"],
        data: List<Groups>.from(json["data"].map((x) => Groups.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Groups {
  String? communityId;
  String? communityName;
  String? communityImage;
  String? description;
  int? memberCount;
  List<String>? memberProfileImages;
  List<String>? memberNames;
  bool? isAdmin;

  Groups({
    required this.communityId,
    required this.communityImage,
    required this.description,
    required this.communityName,
    required this.memberCount,
    required this.memberProfileImages,
    required this.memberNames,
    required this.isAdmin,
  });

  factory Groups.fromJson(Map<String, dynamic> json) => Groups(
        communityId: json["communityId"],
        communityImage: json["communityImage"],
        description: json["communityDescription"],
        communityName: json["communityName"],
        memberCount: json["memberCount"],
        isAdmin: json["isAdmin"] ?? false,
        memberProfileImages:
            List<String>.from(json["memberProfileImages"].map((x) => x)),
        memberNames: List<String>.from(json["memberNames"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "communityId": communityId,
        "communityName": communityName,
        "memberCount": memberCount,
        "memberProfileImages":
            List<dynamic>.from(memberProfileImages!.map((x) => x)),
        "memberNames": List<dynamic>.from(memberNames!.map((x) => x)),
      };
}
