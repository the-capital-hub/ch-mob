// To parse this JSON data, do
//
//     final getCreatedCommunityModel = getCreatedCommunityModelFromJson(jsonString);

import 'dart:convert';

GetCreatedCommunityModel getCreatedCommunityModelFromJson(String str) => GetCreatedCommunityModel.fromJson(json.decode(str));

String getCreatedCommunityModelToJson(GetCreatedCommunityModel data) => json.encode(data.toJson());

class GetCreatedCommunityModel {
    CreatedCommunity data;

    GetCreatedCommunityModel({
        required this.data,
    });

    factory GetCreatedCommunityModel.fromJson(Map<String, dynamic> json) => GetCreatedCommunityModel(
        data: CreatedCommunity.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class CreatedCommunity {
    String image;
    String name;
    String subscription;
    dynamic amount;
    String shareLink;
    // String whatsappGroupLink;

    CreatedCommunity({
        required this.image,
        required this.name,
        required this.subscription,
        required this.amount,
        required this.shareLink
        // required this.whatsappGroupLink,
    });

    factory CreatedCommunity.fromJson(Map<String, dynamic> json) => CreatedCommunity(
        image: json["image"],
        name: json["name"],
        subscription: json["subscription"],
        amount: json["amount"],
        shareLink: json["shareLink"]
        // whatsappGroupLink: json["whatsapp_group_link"]
    );

    Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "subscription": subscription,
        "amount": amount,
        "shareLink":shareLink
        // "whatsapp_group_link" : whatsappGroupLink
    };
}

