// To parse this JSON data, do
//
//     final spotlightProductDetailModel = spotlightProductDetailModelFromJson(jsonString);

import 'dart:convert';

SpotlightProductDetailModel spotlightProductDetailModelFromJson(String str) =>
    SpotlightProductDetailModel.fromJson(json.decode(str));

String spotlightProductDetailModelToJson(SpotlightProductDetailModel data) =>
    json.encode(data.toJson());

class SpotlightProductDetailModel {
  bool? status;
  ProductDetail? data;
  String? message;

  SpotlightProductDetailModel({
    this.status,
    this.data,
    this.message,
  });

  factory SpotlightProductDetailModel.fromJson(Map<String, dynamic> json) =>
      SpotlightProductDetailModel(
        status: json["status"],
        data:
            json["data"] == null ? null : ProductDetail.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
        "message": message,
      };
}

class ProductDetail {
  String? id;
  String? banner;
  String? launchedAt;
  int? upvotesCount;
  int? downvotesCount;
  int? commentsCount;
  int? shareCount;
  Founder? founder;
  String? logo;
  String? title;
  String? tagline;
  bool? isUpvotedByMe;
  bool? isDownvotedByMe;
  String? shareUrl;
  bool? isSavedByMe;
  String? aboutCompany;
  String? industry;
  String? productLink;
  List<SocialLink>? socialLinks;
  List<String>? tags;
  List<String>? coreValueProposition;
  List<FoundingTeam>? foundingTeam;
  List<String>? productImages;
  String? stage;
  List<ProductComment>? comments;

  ProductDetail({
    this.id,
    this.banner,
    this.launchedAt,
    this.upvotesCount,
    this.downvotesCount,
    this.commentsCount,
    this.shareCount,
    this.founder,
    this.logo,
    this.title,
    this.tagline,
    this.isUpvotedByMe,
    this.isDownvotedByMe,
    this.shareUrl,
    this.isSavedByMe,
    this.aboutCompany,
    this.industry,
    this.productLink,
    this.socialLinks,
    this.tags,
    this.coreValueProposition,
    this.foundingTeam,
    this.productImages,
    this.stage,
    this.comments,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        id: json["id"],
        banner: json["banner"],
        launchedAt: json["launchedAt"],
        upvotesCount: json["upvotes_count"],
        downvotesCount: json["downvotes_count"],
        commentsCount: json["comments_count"],
        shareCount: json["shareCount"],
        founder:
            json["founder"] == null ? null : Founder.fromJson(json["founder"]),
        logo: json["logo"],
        title: json["title"],
        tagline: json["tagline"],
        isUpvotedByMe: json["isUpvotedByMe"],
        isDownvotedByMe: json["isDownvotedByMe"],
        shareUrl: json["shareUrl"],
        isSavedByMe: json["isSavedByMe"],
        aboutCompany: json["aboutCompany"],
        industry: json["industry"],
        productLink: json["productLink"],
        socialLinks: json["socialLinks"] == null
            ? []
            : List<SocialLink>.from(
                json["socialLinks"]!.map((x) => SocialLink.fromJson(x))),
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        coreValueProposition: json["coreValueProposition"] == null
            ? []
            : List<String>.from(json["coreValueProposition"]!.map((x) => x)),
        foundingTeam: json["foundingTeam"] == null
            ? []
            : List<FoundingTeam>.from(
                json["foundingTeam"]!.map((x) => FoundingTeam.fromJson(x))),
        productImages: json["productImages"] == null
            ? []
            : List<String>.from(json["productImages"]!.map((x) => x)),
        stage: json["stage"],
        comments: json["comments"] == null
            ? []
            : List<ProductComment>.from(
                json["comments"]!.map((x) => ProductComment.fromJson(x))),
      );
}

class ProductComment {
  String? id;
  String? userName;
  String? userImage;
  String? content;
  String? date;
  CommentType? type;
  List<ReplyProductComment>? replies;
  int? upvotesCount;
  int? downvotesCount;
  bool? isUpvotedByMe;
  bool? isDownvotedByMe;

  ProductComment({
    this.id,
    this.userName,
    this.userImage,
    this.content,
    this.type,
    this.date,
    this.replies,
    this.upvotesCount,
    this.downvotesCount,
    this.isUpvotedByMe,
    this.isDownvotedByMe,
  });

  factory ProductComment.fromJson(Map<String, dynamic> json) => ProductComment(
        id: json["id"],
        userName: json["userName"],
        userImage: json["userImage"],
        content: json["content"],
        date: json["date"],
        type: CommentTypeExtension.fromJson(json["type"]),
        replies: json["replies"] == null
            ? []
            : List<ReplyProductComment>.from(
                json["replies"]!.map((x) => ReplyProductComment.fromJson(x))),
        upvotesCount: json["upvotes_count"],
        downvotesCount: json["downvotes_count"],
        isUpvotedByMe: json["isUpvotedByMe"],
        isDownvotedByMe: json["isDownvotedByMe"],
      );
}

class ReplyProductComment {
  String? id;
  String? userName;
  String? userImage;
  String? content;
  int? upvotesCount;
  int? downvotesCount;
  bool? isUpvotedByMe;
  bool? isDownvotedByMe;

  ReplyProductComment({
    this.id,
    this.userName,
    this.userImage,
    this.content,
    this.upvotesCount,
    this.downvotesCount,
    this.isUpvotedByMe,
    this.isDownvotedByMe,
  });

  factory ReplyProductComment.fromJson(Map<String, dynamic> json) =>
      ReplyProductComment(
        id: json["id"],
        userName: json["userName"],
        userImage: json["userImage"],
        content: json["content"],
        upvotesCount: json["upvotes_count"],
        downvotesCount: json["downvotes_count"],
        isUpvotedByMe: json["isUpvotedByMe"],
        isDownvotedByMe: json["isDownvotedByMe"],
      );
}

enum CommentType { support, roast }

extension CommentTypeExtension on CommentType {
  String toJson() {
    switch (this) {
      case CommentType.support:
        return 'support';
      case CommentType.roast:
        return 'roast';
    }
  }

  static CommentType? fromJson(String? value) {
    switch (value) {
      case 'support':
        return CommentType.support;
      case 'roast':
        return CommentType.roast;
      default:
        return null;
    }
  }
}

class Founder {
  String? id;
  String? firstName;
  String? lastName;
  String? profilePicture;
  String? userName;
  String? bio;

  Founder({
    this.id,
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.userName,
    this.bio,
  });

  factory Founder.fromJson(Map<String, dynamic> json) => Founder(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePicture: json["profilePicture"],
        userName: json["userName"],
        bio: json["bio"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture,
        "userName": userName,
        "bio": bio,
      };
}

class FoundingTeam {
  String? id;
  String? firstName;
  String? lastName;
  String? profilePicture;
  String? userName;
  String? designation;
  String? companyName;
  String? linkedin;
  String? bio;

  FoundingTeam({
    this.id,
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.userName,
    this.designation,
    this.companyName,
    this.linkedin,
    this.bio,
  });

  factory FoundingTeam.fromJson(Map<String, dynamic> json) => FoundingTeam(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePicture: json["profilePicture"],
        userName: json["userName"],
        designation: json["designation"],
        companyName: json["companyName"],
        linkedin: json["linkedin"],
        bio: json["bio"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture,
        "userName": userName,
        "designation": designation,
        "companyName": companyName,
        "linkedin": linkedin,
        "bio": bio,
      };
}

class SocialLink {
  String? name;
  String? link;
  String? logo;

  SocialLink({
    this.name,
    this.link,
    this.logo,
  });

  factory SocialLink.fromJson(Map<String, dynamic> json) => SocialLink(
        name: json["name"],
        link: json["link"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "link": link,
        "logo": logo,
      };
}
