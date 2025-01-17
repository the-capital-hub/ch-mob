// To parse this JSON data, do
//
//     final savedCollectionModel = savedCollectionModelFromJson(jsonString);

import 'dart:convert';

SavedCollectionModel savedCollectionModelFromJson(String str) =>
    SavedCollectionModel.fromJson(json.decode(str));

String savedCollectionModelToJson(SavedCollectionModel data) =>
    json.encode(data.toJson());

class SavedCollectionModel {
  bool? status;
  String? message;
  List<CollectionList>? data;

  SavedCollectionModel({
    this.status,
    this.message,
    this.data,
  });

  factory SavedCollectionModel.fromJson(Map<String, dynamic> json) =>
      SavedCollectionModel(
        status: json["status"],
        message: json["message"],
        data: List<CollectionList>.from(json["data"].map((x) => CollectionList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CollectionList {
  String? name;
  List<String>? posts;
  String? id;
  String? createdAt;
  String? updatedAt;

  CollectionList({
    this.name,
    this.posts,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory CollectionList.fromJson(Map<String, dynamic> json) => CollectionList(
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
