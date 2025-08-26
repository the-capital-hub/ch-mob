// To parse this JSON data, do
//
//     final getTeamMemberModel = getTeamMemberModelFromJson(jsonString);

import 'dart:convert';

GetTeamMemberModel getTeamMemberModelFromJson(String str) => GetTeamMemberModel.fromJson(json.decode(str));

String getTeamMemberModelToJson(GetTeamMemberModel data) => json.encode(data.toJson());

class GetTeamMemberModel {
    bool? status;
    String? message;
    List<TeamMember>? data;

    GetTeamMemberModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetTeamMemberModel.fromJson(Map<String, dynamic> json) => GetTeamMemberModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<TeamMember>.from(json["data"]!.map((x) => TeamMember.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class TeamMember {
    String? name;
    String? designation;
    String? image;
    String? userId;
    String? userName;

    TeamMember({
        this.name,
        this.designation,
        this.image,
        this.userId,
        this.userName,
    });

    factory TeamMember.fromJson(Map<String, dynamic> json) => TeamMember(
        name: json["name"],
        designation: json["designation"],
        image: json["image"],
        userId: json["userId"],
        userName: json["userName"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "designation": designation,
        "image": image,
        "userId": userId,
        "userName": userName,
    };
}
