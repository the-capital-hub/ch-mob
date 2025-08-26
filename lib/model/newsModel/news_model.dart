// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  bool? status;
  String? message;
  List<NewsData>? data;

  NewsModel({
    this.status,
    this.message,
    this.data,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        status: json["status"],
        message: json["message"],
        data: List<NewsData>.from(json["data"].map((x) => NewsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NewsData {
  String? image;
  String? title;
  String? subtitle;
  String? readmoreUrl;

  NewsData({
    this.image,
    this.title,
    this.subtitle,
    this.readmoreUrl,
  });

  factory NewsData.fromJson(Map<String, dynamic> json) => NewsData(
        image: json["image"],
        title: json["title"],
        subtitle: json["subtitle"],
        readmoreUrl: json["readmore_url"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "title": title,
        "subtitle": subtitle,
        "readmore_url": readmoreUrl,
      };
}
