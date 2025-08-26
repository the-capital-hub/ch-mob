// To parse this JSON data, do
//
//     final profilePostModel = profilePostModelFromJson(jsonString);

import 'dart:convert';

import '../homeScreenLandingModel/post_data_model.dart';

CompanyPostModel profilePostModelFromJson(String str) =>
    CompanyPostModel.fromJson(json.decode(str));

String profilePostModelToJson(CompanyPostModel data) =>
    json.encode(data.toJson());

class CompanyPostModel {
  bool? status;
  String? message;
  List<PostData>? data;

  CompanyPostModel({
    this.status,
    this.message,
    this.data,
  });

  factory CompanyPostModel.fromJson(Map<String, dynamic> json) =>
      CompanyPostModel(
        status: json["status"],
        message: json["message"],
        data: List<PostData>.from(
            json["data"].map((x) => PostData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
