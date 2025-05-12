// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

import 'post_data_model.dart';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  bool? status;
  String? message;
  HomeData? data;

  HomeModel({
    this.status,
    this.message,
    this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : HomeData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class HomeData {
  List<String>? hotTopics;
  List<PostData>? posts;
  List<SpotlightProduct>? spotlightProducts;
  List<Community>? communities;

  HomeData({
    this.hotTopics,
    this.posts,
    this.spotlightProducts,
    this.communities,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        hotTopics: json["hotTopics"] == null
            ? []
            : List<String>.from(json["hotTopics"]!.map((x) => x)),
        posts: json["posts"] == null
            ? []
            : List<PostData>.from(
                json["posts"]!.map((x) => PostData.fromJson(x))),
        spotlightProducts: json["spotlightProducts"] == null
            ? []
            : List<SpotlightProduct>.from(json["spotlightProducts"]!
                .map((x) => SpotlightProduct.fromJson(x))),
        communities: json["communities"] == null
            ? []
            : List<Community>.from(
                json["communities"]!.map((x) => Community.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "hotTopics": hotTopics == null
            ? []
            : List<dynamic>.from(hotTopics!.map((x) => x)),
        "posts": posts == null
            ? []
            : List<dynamic>.from(posts!.map((x) => x.toJson())),
        "spotlightProducts": spotlightProducts == null
            ? []
            : List<dynamic>.from(spotlightProducts!.map((x) => x.toJson())),
        "communities": communities == null
            ? []
            : List<dynamic>.from(communities!.map((x) => x.toJson())),
      };
}

class Community {
  String? communityId;
  String? name;
  String? image;
  int? memberCount;
  String? subscription;
  String? price;
  Admin? admin;

  Community({
    this.communityId,
    this.name,
    this.image,
    this.memberCount,
    this.subscription,
    this.price,
    this.admin,
  });

  factory Community.fromJson(Map<String, dynamic> json) => Community(
        communityId: json["communityId"],
        name: json["name"],
        image: json["image"],
        memberCount: json["memberCount"],
        subscription: json["subscription"],
        price: json["price"].toString(),
        admin: json["admin"] == null ? null : Admin.fromJson(json["admin"]),
      );

  Map<String, dynamic> toJson() => {
        "communityId": communityId,
        "name": name,
        "image": image,
        "memberCount": memberCount,
        "subscription": subscription,
        "price": price,
        "admin": admin?.toJson(),
      };
}

class Admin {
  String? name;
  String? profilePicture;

  Admin({
    this.name,
    this.profilePicture,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        name: json["name"],
        profilePicture: json["profilePicture"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "profilePicture": profilePicture,
      };
}

class SpotlightProduct {
  String? productId;
  String? title;
  String? logo;
  String? banner;
  String? tagline;
  List<String>? industryTags;
  int? upvotes;
  int? downvotes;
  int? commentsCount;
  int? savedCount;
  int? shareCount;
  Admin? founder;
  int? rank;

  SpotlightProduct({
    this.productId,
    this.title,
    this.logo,
    this.banner,
    this.tagline,
    this.industryTags,
    this.upvotes,
    this.downvotes,
    this.commentsCount,
    this.savedCount,
    this.shareCount,
    this.founder,
    this.rank,
  });

  factory SpotlightProduct.fromJson(Map<String, dynamic> json) =>
      SpotlightProduct(
        productId: json["productId"],
        title: json["title"],
        logo: json["logo"],
        banner: json["banner"],
        tagline: json["tagline"],
        industryTags: json["industryTags"] == null
            ? []
            : List<String>.from(json["industryTags"]!.map((x) => x)),
        upvotes: json["upvotes"],
        downvotes: json["downvotes"],
        commentsCount: json["commentsCount"],
        savedCount: json["savedCount"],
        shareCount: json["shareCount"],
        founder:
            json["founder"] == null ? null : Admin.fromJson(json["founder"]),
        rank: json["rank"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "title": title,
        "logo": logo,
        "banner": banner,
        "tagline": tagline,
        "industryTags": industryTags == null
            ? []
            : List<dynamic>.from(industryTags!.map((x) => x)),
        "upvotes": upvotes,
        "downvotes": downvotes,
        "commentsCount": commentsCount,
        "savedCount": savedCount,
        "shareCount": shareCount,
        "founder": founder?.toJson(),
        "rank": rank,
      };
}
