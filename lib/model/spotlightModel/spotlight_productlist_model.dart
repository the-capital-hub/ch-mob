// To parse this JSON data, do
//
//     final spotlightProductListModel = spotlightProductListModelFromJson(jsonString);

import 'dart:convert';

SpotlightProductListModel spotlightProductListModelFromJson(String str) =>
    SpotlightProductListModel.fromJson(json.decode(str));

String spotlightProductListModelToJson(SpotlightProductListModel data) =>
    json.encode(data.toJson());

class SpotlightProductListModel {
  bool? status;
  String? message;
  SpotlightData? data;

  SpotlightProductListModel({
    this.status,
    this.message,
    this.data,
  });

  factory SpotlightProductListModel.fromJson(Map<String, dynamic> json) =>
      SpotlightProductListModel(
        status: json["status"],
        message: json["message"],
        data:
            json["data"] == null ? null : SpotlightData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class SpotlightData {
  List<String>? industries;
  List<SpotlightProduct> products = [];

  SpotlightData({
    this.industries,
    required this.products,
  });

  factory SpotlightData.fromJson(Map<String, dynamic> json) => SpotlightData(
        industries: json["industries"] == null
            ? []
            : List<String>.from(json["industries"]!.map((x) => x)),
        products: json["products"] == null
            ? []
            : List<SpotlightProduct>.from(
                json["products"]!.map((x) => SpotlightProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "industries": industries == null
            ? []
            : List<dynamic>.from(industries!.map((x) => x)),
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class SpotlightProduct {
  String? id;
  String? title;
  String? logo;
  String? tagline;
  DateTime? date;
  List<String>? tags;
  int? upvotesCount;
  int? downvoteCount;
  int? comments;
  int? shares;
  bool? topProduct;
  bool? isUpvotedByMe;
  bool? isDownvotedByMe;

  SpotlightProduct({
    this.id,
    this.title,
    this.tagline,
    this.logo,
    this.tags,
    this.date,
    this.upvotesCount,
    this.downvoteCount,
    this.isUpvotedByMe,
    this.isDownvotedByMe,
    this.comments,
    this.shares,
    this.topProduct,
  });

  factory SpotlightProduct.fromJson(Map<String, dynamic> json) =>
      SpotlightProduct(
        id: json["id"],
        title: json["title"],
        logo: json['logo'],
        tagline: json["tagline"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        upvotesCount: json["upvotes_count"],
        downvoteCount: json["downvotes_count"],
        comments: json["comments_count"],
        shares: json["share_count"],
        topProduct: json["topProduct"],
        date: DateTime.parse(json['date']),
        isUpvotedByMe: json["isUpvotedByMe"] ?? false,
        isDownvotedByMe: json["isDownvotedByMe"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": tagline,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "likes": upvotesCount,
        "comments": comments,
        "flames": shares,
        "topProduct": topProduct,
      };
}
