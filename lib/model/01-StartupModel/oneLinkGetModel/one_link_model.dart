// To parse this JSON data, do
//
//     final oneLinkGetModel = oneLinkGetModelFromJson(jsonString);

import 'dart:convert';

OneLinkGetModel oneLinkGetModelFromJson(String str) =>
    OneLinkGetModel.fromJson(json.decode(str));

String oneLinkGetModelToJson(OneLinkGetModel data) =>
    json.encode(data.toJson());

class OneLinkGetModel {
  bool? status;
  String? message;
  OneLinkData? data;

  OneLinkGetModel({
    this.status,
    this.message,
    this.data,
  });

  factory OneLinkGetModel.fromJson(Map<String, dynamic> json) =>
      OneLinkGetModel(
        status: json["status"],
        message: json["message"],
        data: OneLinkData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class OneLinkData {
  String? startUpId;
  String? name;
  String? oneLink;
  String? introductoryMessage;
  String? secretOneLinkKey;
  List<String>? previousIntroductoryMessage;

  OneLinkData({
    this.startUpId,
    this.name,
    this.oneLink,
    this.introductoryMessage,
    this.secretOneLinkKey,
    this.previousIntroductoryMessage,
  });

  factory OneLinkData.fromJson(Map<String, dynamic> json) => OneLinkData(
        startUpId: json["startUpId"],
        name: json["name"],
        oneLink: json["oneLink"],
        introductoryMessage: json["introductoryMessage"],
        secretOneLinkKey: json["secretOneLinkKey"],
        previousIntroductoryMessage: List<String>.from(
            json["previousIntroductoryMessage"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "startUpId": startUpId,
        "name": name,
        "oneLink": oneLink,
        "introductoryMessage": introductoryMessage,
        "secretOneLinkKey": secretOneLinkKey,
        "previousIntroductoryMessage":
            List<dynamic>.from(previousIntroductoryMessage!.map((x) => x)),
      };
}
