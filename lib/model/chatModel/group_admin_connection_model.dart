// To parse this JSON data, do
//
//     final groupAdminConnection = groupAdminConnectionFromJson(jsonString);

import 'dart:convert';

GroupAdminConnection groupAdminConnectionFromJson(String str) => GroupAdminConnection.fromJson(json.decode(str));

String groupAdminConnectionToJson(GroupAdminConnection data) => json.encode(data.toJson());

class GroupAdminConnection {
    bool? status;
    String? message;
    List<AdminConnections>? data;

    GroupAdminConnection({
        this.status,
        this.message,
        this.data,
    });

    factory GroupAdminConnection.fromJson(Map<String, dynamic> json) => GroupAdminConnection(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<AdminConnections>.from(json["data"]!.map((x) => AdminConnections.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class AdminConnections {
    String? id;
    String? name;
    String? imageUrl;
    bool? isMember;

    AdminConnections({
        this.id,
        this.name,
        this.imageUrl,
        this.isMember,
    });

    factory AdminConnections.fromJson(Map<String, dynamic> json) => AdminConnections(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        isMember: json["isMember"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "isMember": isMember,
    };
}
