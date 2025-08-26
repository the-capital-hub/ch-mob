// // To parse this JSON data, do
// //
// //     final SavedCommunityCollectionModel = SavedCommunityCollectionModelFromJson(jsonString);

// import 'dart:convert';

// SavedCommunityCollectionModel SavedCommunityCollectionModelFromJson(String str) =>
//     SavedCommunityCollectionModel.fromJson(json.decode(str));

// String SavedCommunityCollectionModelToJson(SavedCommunityCollectionModel data) =>
//     json.encode(data.toJson());

// class SavedCommunityCollectionModel {
//   bool? status;
//   String? message;
//   List<CommunityCollection>? data;

//   SavedCommunityCollectionModel({
//     this.status,
//     this.message,
//     this.data,
//   });

//   factory SavedCommunityCollectionModel.fromJson(Map<String, dynamic> json) =>
//       SavedCommunityCollectionModel(
//         status: json["status"],
//         message: json["message"],
//         data: List<CommunityCollection>.from(json["data"].map((x) => CommunityCollection.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

// class CommunityCollection {
//   String? name;
//   List<String>? posts;
//   String? id;
//   String? createdAt;
//   String? updatedAt;

//   CommunityCollection({
//     this.name,
//     this.posts,
//     this.id,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory CommunityCollection.fromJson(Map<String, dynamic> json) => CommunityCollection(
//         name: json["name"],
//         posts: List<String>.from(json["posts"].map((x) => x)),
//         id: json["_id"],
//         createdAt: json["createdAt"],
//         updatedAt: json["updatedAt"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "posts": List<dynamic>.from(posts!.map((x) => x)),
//         "_id": id,
//         "createdAt": createdAt,
//         "updatedAt": updatedAt,
//       };
// }
// To parse this JSON data, do
//
//     final getSavedCommunityCollectionModel = getSavedCommunityCollectionModelFromJson(jsonString);

import 'dart:convert';

GetSavedCommunityCollectionModel getSavedCommunityCollectionModelFromJson(String str) => GetSavedCommunityCollectionModel.fromJson(json.decode(str));

String getSavedCommunityCollectionModelToJson(GetSavedCommunityCollectionModel data) => json.encode(data.toJson());

class GetSavedCommunityCollectionModel {
    bool status;
    String message;
    List<CommunityCollection> data;

    GetSavedCommunityCollectionModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetSavedCommunityCollectionModel.fromJson(Map<String, dynamic> json) => GetSavedCommunityCollectionModel(
        status: json["status"],
        message: json["message"],
        data: List<CommunityCollection>.from(json["data"].map((x) => CommunityCollection.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class CommunityCollection {
    String name;
    List<Post> posts;
    String id;
    DateTime createdAt;
    DateTime updatedAt;

    CommunityCollection({
        required this.name,
        required this.posts,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
    });

    factory CommunityCollection.fromJson(Map<String, dynamic> json) => CommunityCollection(
        name: json["name"],
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class Post {
    String id;
    String category;
    String description;
    String user;
    List<String> images;
    List<String> likes;
    String postType;
    bool allowMultipleAnswers;
    String communityId;
    List<dynamic> comments;
    List<dynamic> pollOptions;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Post({
        required this.id,
        required this.category,
        required this.description,
        required this.user,
        required this.images,
        required this.likes,
        required this.postType,
        required this.allowMultipleAnswers,
        required this.communityId,
        required this.comments,
        required this.pollOptions,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        category: json["category"],
        description: json["description"],
        user: json["user"],
        images: List<String>.from(json["images"].map((x) => x)),
        likes: List<String>.from(json["likes"].map((x) => x)),
        postType: json["postType"],
        allowMultipleAnswers: json["allow_multiple_answers"],
        communityId: json["communityId"],
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        pollOptions: List<dynamic>.from(json["pollOptions"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "category": category,
        "description": description,
        "user": user,
        "images": List<dynamic>.from(images.map((x) => x)),
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "postType": postType,
        "allow_multiple_answers": allowMultipleAnswers,
        "communityId": communityId,
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "pollOptions": List<dynamic>.from(pollOptions.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
