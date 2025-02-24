// To parse this JSON data, do
//
//     final publicPostModel = publicPostModelFromJson(jsonString);

import 'dart:convert';

import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityLandingAllModels/communityPostModel/reshare_community_model.dart';

CommunityPostModel publicPostModelFromJson(String str) =>
    CommunityPostModel.fromJson(json.decode(str));

String publicPostModelToJson(CommunityPostModel data) =>
    json.encode(data.toJson());

class CommunityPostModel {
  bool? status;
  String? message;
  List<CommunityPost>? data;

  CommunityPostModel({
    this.status,
    this.message,
    this.data,
  });

  factory CommunityPostModel.fromJson(Map<String, dynamic> json) =>
      CommunityPostModel(
        status: json["status"],
        message: json["message"],
        data: List<CommunityPost>.from(
            json["data"].map((x) => CommunityPost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CommunityPost {
  String? postId;
  String? postType;
  bool? isMyPost;
  String? description;
  bool? isSaved;
  bool? isLiked;
  List<String>? image;
  String? video_url;
  String? document_url;
  List<PollOptionData>? pollOptions;
  List<String>? myVotes;
  int? totalVotes;
  List<Like>? likes;
  List<Comment>? comments;
  String? createdAt;
  String? connectionStatus;
  String? userId;
  String? userFirstName;
  String? userLastName;
  String? userImage;
  String? userDesignation;
  String? userCompany;
  bool? userIsSubscribed;
  ResharedCommunityPostData? resharedPostData;

  CommunityPost(
      {this.postId,
      this.postType,
      this.isMyPost,
      this.description,
      this.isSaved,
      this.isLiked,
      this.video_url,
      this.document_url,
      this.image,
      this.pollOptions,
      this.myVotes,
      this.totalVotes,
      this.likes,
      this.comments,
      this.createdAt,
      this.connectionStatus,
      this.userId,
      this.userFirstName,
      this.userLastName,
      this.userImage,
      this.userDesignation,
      this.userCompany,
      this.userIsSubscribed,
      this.resharedPostData});

  factory CommunityPost.fromJson(Map<String, dynamic> json) => CommunityPost(
      postId: json["postId"],
      postType: json["postType"],
      isMyPost: json["isMyPost"],
      description: json["description"],
      isSaved: json["isSaved"],
      isLiked: json["isLiked"],
      image: List<String>.from(json["image"].map((x) => x)),
      pollOptions: List<PollOptionData>.from(
          json["pollOptions"].map((x) => PollOptionData.fromJson(x))),
      myVotes: List<String>.from(json["myVotes"].map((x) => x)),
      totalVotes: json["totalVotes"],
      likes: List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
      comments:
          List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
      createdAt: json["createdAt"],
      connectionStatus: json["connection_status"],
      document_url: json['documentUrl'],
      video_url: json['video'],
      userId: json["userId"],
      userFirstName: json["userFirstName"],
      userLastName: json["userLastName"],
      userImage: json["userImage"],
      userDesignation: json["userDesignation"],
      userCompany: json["userCompany"],
      userIsSubscribed: json["userIsSubscribed"]??false,
      resharedPostData: json["resharedPostData"] != null
          ? ResharedCommunityPostData.fromJson(json["resharedPostData"])
          : null);

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "postType": postType,
        "isMyPost": isMyPost,
        "description": description,
        "isSaved": isSaved,
        "isLiked": isLiked,
        "image": List<dynamic>.from(image!.map((x) => x)),
        "pollOptions": List<dynamic>.from(pollOptions!.map((x) => x.toJson())),
        "myVotes": List<dynamic>.from(myVotes!.map((x) => x)),
        "totalVotes": totalVotes,
        "likes": List<dynamic>.from(likes!.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
        "createdAt": createdAt,
        "userId": userId,
        "userFirstName": userFirstName,
        "userLastName": userLastName,
        "userImage": userImage,
        "userDesignation": userDesignation,
        "userCompany": userCompany,
        "userIsSubscribed": userIsSubscribed,
      };
}

class Comment {
  String? id;
  String? text;
  String? user;
  String? userDesignation;
  String? userCompany;
  String? userImage;
  String? createdAt;
  String? likesCount;
  bool? isMyComment;
  bool? isLiked;

  Comment({
    this.id,
    this.text,
    this.user,
    this.userDesignation,
    this.userCompany,
    this.userImage,
    this.createdAt,
    this.likesCount,
    this.isMyComment,
    this.isLiked,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["_id"],
        text: json["text"],
        user: json["user"],
        userDesignation: json["userDesignation"],
        userCompany: json["userCompany"],
        userImage: json["userImage"],
        createdAt: json["createdAt"],
        likesCount: json["likesCount"],
        isMyComment: json["isMyComment"],
        isLiked: json["isLiked"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "text": text,
        "user": user,
        "userDesignation": userDesignation,
        "userCompany": userCompany,
        "userImage": userImage,
        "createdAt": createdAt,
        "likesCount": likesCount,
        "isMyComment": isMyComment,
        "isLiked": isLiked,
      };
}

class Like {
  String? id;
  String? firstName;
  String? lastName;

  Like({
    this.id,
    this.firstName,
    this.lastName,
  });

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
      };
}

class PollOptionData {
  String? id;
  String? option;
  int numberOfVotes;
  bool? hasVoted;

  PollOptionData({
    this.id,
    this.option,
    required this.numberOfVotes,
    this.hasVoted,
  });

  factory PollOptionData.fromJson(Map<String, dynamic> json) => PollOptionData(
        id: json["_id"],
        option: json["option"],
        numberOfVotes: json["numberOfVotes"] ?? 0,
        hasVoted: json["hasVoted"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "option": option,
        "numberOfVotes": numberOfVotes,
        "hasVoted": hasVoted,
      };
}
