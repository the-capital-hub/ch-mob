// To parse this JSON data, do
//
//     final communityCornerModel = communityCornerModelFromJson(jsonString);

import 'dart:convert';

CommunityCornerModel communityCornerModelFromJson(String str) => CommunityCornerModel.fromJson(json.decode(str));

String communityCornerModelToJson(CommunityCornerModel data) => json.encode(data.toJson());

class CommunityCornerModel {
    bool? status;
    String? message;
    List<CommunityCornerData>? data;

    CommunityCornerModel({
        this.status,
        this.message,
        this.data,
    });

    factory CommunityCornerModel.fromJson(Map<String, dynamic> json) => CommunityCornerModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<CommunityCornerData>.from(json["data"]!.map((x) => CommunityCornerData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class CommunityCornerData {
    String? id;
    String? name;
    String? image;
    int? memberSize;
    String? amount;

    CommunityCornerData({
        this.id,
        this.name,
        this.image,
        this.memberSize,
        this.amount,
    });

    factory CommunityCornerData.fromJson(Map<String, dynamic> json) => CommunityCornerData(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        memberSize: json["memberSize"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "memberSize": memberSize,
        "amount": amount,
    };
}
