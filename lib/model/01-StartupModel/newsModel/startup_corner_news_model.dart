// To parse this JSON data, do
//
//     final startupCornerNews = startupCornerNewsFromJson(jsonString);

import 'dart:convert';

StartupCornerNews startupCornerNewsFromJson(String str) =>
    StartupCornerNews.fromJson(json.decode(str));

String startupCornerNewsToJson(StartupCornerNews data) =>
    json.encode(data.toJson());

class StartupCornerNews {
  bool? status;
  String? message;
  List<StartupNews>? data;

  StartupCornerNews({
    this.status,
    this.message,
    this.data,
  });

  factory StartupCornerNews.fromJson(Map<String, dynamic> json) =>
      StartupCornerNews(
        status: json["status"],
        message: json["message"],
        data: List<StartupNews>.from(json["data"].map((x) => StartupNews.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class StartupNews {
  String? image;
  String? title;
  String? author;
  String? content;
  String? postedAt;
  String? sourceUrl;
  String? readMore;

  StartupNews({
    this.image,
    this.title,
    this.author,
    this.content,
    this.postedAt,
    this.sourceUrl,
    this.readMore,
  });

  factory StartupNews.fromJson(Map<String, dynamic> json) => StartupNews(
        image: json["image"],
        title: json["title"],
        author: json["author"],
        content: json["content"],
        postedAt: json["postedAt"],
        sourceUrl: json["sourceURL"],
        readMore: json["readMore"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "title": title,
        "author": author,
        "content": content,
        "postedAt": postedAt,
        "sourceURL": sourceUrl,
        "readMore": readMore,
      };
}
