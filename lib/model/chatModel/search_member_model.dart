// To parse this JSON data, do
//
//     final memberChat = memberChatFromJson(jsonString);

import 'dart:convert';

SearchMemberModel memberChatFromJson(String str) =>
    SearchMemberModel.fromJson(json.decode(str));

class SearchMemberModel {
  bool status;
  String message;
  List<SearchMember> data;

  SearchMemberModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SearchMemberModel.fromJson(Map<String, dynamic> json) =>
      SearchMemberModel(
        status: json["status"],
        message: json["message"],
        data: List<SearchMember>.from(
            json["data"].map((x) => SearchMember.fromJson(x))),
      );
}

class SearchMember {
  String name;
  String userId;
  String profile;
  String designation;

  SearchMember({
    required this.name,
    required this.userId,
    required this.profile,
    required this.designation,
  });

  factory SearchMember.fromJson(Map<String, dynamic> json) => SearchMember(
        name: json["fullName"],
        userId: json["id"],
        profile: json["profilePicture"],
        designation: json["designation"],
      );
}
