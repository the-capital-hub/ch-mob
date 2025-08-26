// To parse this JSON data, do
//
//     final commentsModel = commentsModelFromJson(jsonString);

import 'dart:convert';

CommentsModel commentsModelFromJson(String str) =>
    CommentsModel.fromJson(json.decode(str));

String commentsModelToJson(CommentsModel data) => json.encode(data.toJson());

class CommentsModel {
  bool? status;
  String? message;
  List<CommentData>? data;

  CommentsModel({
    this.status,
    this.message,
    this.data,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<CommentData>.from(
                json["data"]!.map((x) => CommentData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CommentData {
  String? id;
  String? text;
  User? user;
  String? createdAt;
  int likesCount;
  bool? isLikedByMe;
  bool? isMyComment;

  CommentData({
    this.id,
    this.text,
    this.user,
    this.createdAt,
    required this.likesCount,
    this.isLikedByMe,
    this.isMyComment,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
        id: json["_id"],
        text: json["text"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        createdAt: json["createdAt"],
        likesCount: json["likesCount"] ?? 0,
        isLikedByMe: json["isLikedByMe"],
        isMyComment: json["isMyComment"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "text": text,
        "user": user?.toJson(),
        "createdAt": createdAt,
        "likesCount": likesCount,
        "isLikedByMe": isLikedByMe,
        "isMyComment": isMyComment,
      };
}

class User {
  String? id;
  String? name;
  String? profilePicture;
  String? bio;

  User({
    this.id,
    this.name,
    this.profilePicture,
    this.bio,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        profilePicture: json["profilePicture"],
        bio: json["bio"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "profilePicture": profilePicture,
        "bio": bio,
      };
}
