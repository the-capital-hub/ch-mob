// To parse this JSON data, do
//
//     final createChatModel = createChatModelFromJson(jsonString);

import 'dart:convert';

import 'chat_memberlist_model.dart';

CreateChatModel createChatModelFromJson(String str) => CreateChatModel.fromJson(json.decode(str));

String createChatModelToJson(CreateChatModel data) => json.encode(data.toJson());

class CreateChatModel {
    bool status;
    String message;
    ChatMember data;

    CreateChatModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CreateChatModel.fromJson(Map<String, dynamic> json) => CreateChatModel(
        status: json["status"],
        message: json["message"],
        data: ChatMember.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

