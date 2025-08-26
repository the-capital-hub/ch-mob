// To parse this JSON data, do
//
//     final profilePostModel = profilePostModelFromJson(jsonString);

import 'dart:convert';

import '../homeScreenLandingModel/post_data_model.dart';

ProfilePostModel profilePostModelFromJson(String str) =>
    ProfilePostModel.fromJson(json.decode(str));

String profilePostModelToJson(ProfilePostModel data) =>
    json.encode(data.toJson());

class ProfilePostModel {
  bool? status;
  String? message;
  List<PostData>? data;

  ProfilePostModel({
    this.status,
    this.message,
    this.data,
  });

  factory ProfilePostModel.fromJson(Map<String, dynamic> json) =>
      ProfilePostModel(
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

class ProfilePost {
  String? userProfilePicture;
  String? userDesignation;
  String? userFirstName;
  String? userLastName;
  String? userLocation;
  String? postId;
  List<PollOptionData>? pollOptions;
  List<String>? myVotes;
  int? totalVotes;

  String? description;
  List<String>? images;
  String? age;

  ProfilePost({
    this.userProfilePicture,
    this.userDesignation,
    this.userFirstName,
    this.userLastName,
    this.userLocation,
    this.postId,
    this.pollOptions,
    this.myVotes,
    this.totalVotes,
    this.description,
    this.images,
    this.age,
  });

  factory ProfilePost.fromJson(Map<String, dynamic> json) => ProfilePost(
        userProfilePicture: json["userProfilePicture"],
        userDesignation: json["userDesignation"],
        userFirstName: json["userFirstName"],
        userLastName: json["userLastName"],
        userLocation: json["userLocation"],
        postId: json["postId"],
        pollOptions: List<PollOptionData>.from(
            json["pollOptions"].map((x) => PollOptionData.fromJson(x))),
        myVotes: List<String>.from(json["myVotes"].map((x) => x)),
        totalVotes: json["totalVotes"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "userProfilePicture": userProfilePicture,
        "userDesignation": userDesignation,
        "userFirstName": userFirstName,
        "userLastName": userLastName,
        "userLocation": userLocation,
        "postId": postId,
        "description": description,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "age": age,
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
