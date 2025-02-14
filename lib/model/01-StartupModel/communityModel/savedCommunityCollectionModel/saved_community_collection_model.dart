// To parse this JSON data, do
//
//     final SavedCommunityCollectionModel = SavedCommunityCollectionModelFromJson(jsonString);

import 'dart:convert';

SavedCommunityCollectionModel SavedCommunityCollectionModelFromJson(String str) =>
    SavedCommunityCollectionModel.fromJson(json.decode(str));

String SavedCommunityCollectionModelToJson(SavedCommunityCollectionModel data) =>
    json.encode(data.toJson());

class SavedCommunityCollectionModel {
  bool? status;
  String? message;
  List<CommunityCollection>? data;

  SavedCommunityCollectionModel({
    this.status,
    this.message,
    this.data,
  });

  factory SavedCommunityCollectionModel.fromJson(Map<String, dynamic> json) =>
      SavedCommunityCollectionModel(
        status: json["status"],
        message: json["message"],
        data: List<CommunityCollection>.from(json["data"].map((x) => CommunityCollection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CommunityCollection {
  String? name;
  List<String>? posts;
  String? id;
  String? createdAt;
  String? updatedAt;

  CommunityCollection({
    this.name,
    this.posts,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory CommunityCollection.fromJson(Map<String, dynamic> json) => CommunityCollection(
        name: json["name"],
        posts: List<String>.from(json["posts"].map((x) => x)),
        id: json["_id"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "posts": List<dynamic>.from(posts!.map((x) => x)),
        "_id": id,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
