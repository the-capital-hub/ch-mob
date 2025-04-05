// To parse this JSON data, do
//
//     final searchUserModel = searchUserModelFromJson(jsonString);

import 'dart:convert';

SearchUserModel searchUserModelFromJson(String str) => SearchUserModel.fromJson(json.decode(str));

String searchUserModelToJson(SearchUserModel data) => json.encode(data.toJson());

class SearchUserModel {
    bool? status;
    List<UserData>? data;

    SearchUserModel({
        this.status,
        this.data,
    });

    factory SearchUserModel.fromJson(Map<String, dynamic> json) => SearchUserModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<UserData>.from(json["data"]!.map((x) => UserData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class UserData {
    String? userId;
    String? firstName;
    String? lastName;
    String? profilePicture;

    UserData({
        this.userId,
        this.firstName,
        this.lastName,
        this.profilePicture,
    });

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePicture: json["profilePicture"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture,
    };
}
