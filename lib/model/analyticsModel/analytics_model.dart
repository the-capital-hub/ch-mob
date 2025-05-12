// To parse this JSON data, do
//
//     final analyticsModel = analyticsModelFromJson(jsonString);

import 'dart:convert';

AnalyticsModel analyticsModelFromJson(String str) => AnalyticsModel.fromJson(json.decode(str));

String analyticsModelToJson(AnalyticsModel data) => json.encode(data.toJson());

class AnalyticsModel {
    bool? status;
    String? message;
    AnalyticsData? data;

    AnalyticsModel({
        this.status,
        this.message,
        this.data,
    });

    factory AnalyticsModel.fromJson(Map<String, dynamic> json) => AnalyticsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : AnalyticsData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class AnalyticsData {
    int? profileViews;
    int? followers;
    int? posts;
    int? comments;

    AnalyticsData({
        this.profileViews,
        this.followers,
        this.posts,
        this.comments,
    });

    factory AnalyticsData.fromJson(Map<String, dynamic> json) => AnalyticsData(
        profileViews: json["profileViews"],
        followers: json["followers"],
        posts: json["posts"],
        comments: json["comments"],
    );

    Map<String, dynamic> toJson() => {
        "profileViews": profileViews,
        "followers": followers,
        "posts": posts,
        "comments": comments,
    };
}
