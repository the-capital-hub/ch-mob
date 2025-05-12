// To parse this JSON data, do
//
//     final spotlightRequestModel = spotlightRequestModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

SpotlightRequestModel spotlightRequestModelFromJson(String str) =>
    SpotlightRequestModel.fromJson(json.decode(str));

String spotlightRequestModelToJson(SpotlightRequestModel data) =>
    json.encode(data.toJson());

class SpotlightRequestModel {
  bool? status;
  String? message;
  List<RequestData>? data;

  SpotlightRequestModel({
    this.status,
    this.message,
    this.data,
  });

  factory SpotlightRequestModel.fromJson(Map<String, dynamic> json) =>
      SpotlightRequestModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<RequestData>.from(
                json["data"]!.map((x) => RequestData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class RequestData {
  String? id;
  String? productId;
  String? title;
  String? logo;
  String? tagline;
  List<String>? tags;
  String? remarkText;
  String? createdAt;
  List<SubmissionHistory>? submissionHistory;

  RequestData({
    this.id,
    this.productId,
    this.title,
    this.logo,
    this.tagline,
    this.tags,
    this.remarkText,
    this.createdAt,
    this.submissionHistory,
  });

  factory RequestData.fromJson(Map<String, dynamic> json) => RequestData(
        id: json["id"],
        productId: json["productId"],
        title: json["title"],
        logo: json["logo"],
        tagline: json["tagline"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        remarkText: json["remarkText"],
        createdAt: json["createdAt"],
        submissionHistory: json["submissionHistory"] == null
            ? []
            : List<SubmissionHistory>.from(json["submissionHistory"]!
                .map((x) => SubmissionHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "title": title,
        "logo": logo,
        "tagline": tagline,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "remarkText": remarkText,
        "createdAt": createdAt,
        "submissionHistory": submissionHistory == null
            ? []
            : List<dynamic>.from(submissionHistory!.map((x) => x.toJson())),
      };
}

class SubmissionHistory {
  String? date;
  String? status;

  SubmissionHistory({
    this.date,
    this.status,
  });

  factory SubmissionHistory.fromJson(Map<String, dynamic> json) =>
      SubmissionHistory(
        date: json["date"],
        status: json["status"].toString().capitalizeFirst,
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "status": status,
      };
}
