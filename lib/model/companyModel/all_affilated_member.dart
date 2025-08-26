// To parse this JSON data, do
//
//     final allAffilatedMember = allAffilatedMemberFromJson(jsonString);

import 'dart:convert';

AllAffilatedMember allAffilatedMemberFromJson(String str) => AllAffilatedMember.fromJson(json.decode(str));

String allAffilatedMemberToJson(AllAffilatedMember data) => json.encode(data.toJson());

class AllAffilatedMember {
    bool? status;
    String? message;
    List<StartupMember>? data;

    AllAffilatedMember({
        this.status,
        this.message,
        this.data,
    });

    factory AllAffilatedMember.fromJson(Map<String, dynamic> json) => AllAffilatedMember(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<StartupMember>.from(json["data"]!.map((x) => StartupMember.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class StartupMember {
    String? id;
    String? firstName;
    String? lastName;
    String? profilePicture;
    String? email;

    StartupMember({
        this.id,
        this.firstName,
        this.lastName,
        this.profilePicture,
        this.email,
    });

    factory StartupMember.fromJson(Map<String, dynamic> json) => StartupMember(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePicture: json["profilePicture"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture,
        "email": email,
    };
}
