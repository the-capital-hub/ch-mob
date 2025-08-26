// // To parse this JSON data, do
// //
// //     final myCommunitiesModel = myCommunitiesModelFromJson(jsonString);

// import 'dart:convert';

// MyCommunitiesModel myCommunitiesModelFromJson(String str) => MyCommunitiesModel.fromJson(json.decode(str));

// String myCommunitiesModelToJson(MyCommunitiesModel data) => json.encode(data.toJson());

// class MyCommunitiesModel {
//     bool status;
//     String message;
//     List<MyCommunities> data;

//     MyCommunitiesModel({
//         required this.status,
//         required this.message,
//         required this.data,
//     });

//     factory MyCommunitiesModel.fromJson(Map<String, dynamic> json) => MyCommunitiesModel(
//         status: json["status"],
//         message: json["message"],
//         data: List<MyCommunities>.from(json["data"].map((x) => MyCommunities.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }

// class MyCommunities {
//     String id;
//     String image;
//     String name;
//     String size;
//     String subscription;
//     String amount;
//     String adminId;
//     bool isOpen;
//     List<MemberElement> members;
//     DateTime createdAt;
//     DateTime updatedAt;
//     int v;
//     String about;
//     List<dynamic> posts;
//     List<Product> products;
//     List<String> termsAndConditions;
//     bool isDeleted;
//     List<RemovedMember> removedMembers;
//     String whatsappGroupLink;
//     String bannerImage;
//     String role;
//     String createdAtTimeAgo;
//     String shareLink;

//     MyCommunities({
//         required this.id,
//         required this.image,
//         required this.name,
//         required this.size,
//         required this.subscription,
//         required this.amount,
//         required this.adminId,
//         required this.isOpen,
//         required this.members,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.v,
//         required this.about,
//         required this.posts,
//         required this.products,
//         required this.termsAndConditions,
//         required this.isDeleted,
//         required this.removedMembers,
//         required this.whatsappGroupLink,
//         required this.bannerImage,
//         required this.role,
//         required this.createdAtTimeAgo,
//         required this.shareLink,
//     });

//     factory MyCommunities.fromJson(Map<String, dynamic> json) => MyCommunities(
//         id: json["_id"],
//         image: json["image"],
//         name: json["name"],
//         size: json["size"],
//         subscription: json["subscription"],
//         amount: json["amount"],
//         adminId: json["adminId"],
//         isOpen: json["isOpen"],
//         members: List<MemberElement>.from(json["members"].map((x) => MemberElement.fromJson(x))),
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//         about: json["about"],
//         posts: List<dynamic>.from(json["posts"].map((x) => x)),
//         products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
//         termsAndConditions: List<String>.from(json["terms_and_conditions"].map((x) => x)),
//         isDeleted: json["is_deleted"],
//         removedMembers: List<RemovedMember>.from(json["removed_members"].map((x) => RemovedMember.fromJson(x))),
//         whatsappGroupLink: json["whatsapp_group_link"],
//         bannerImage: json["banner_image"],
//         role: json["role"],
//         createdAtTimeAgo: json["createdAtTimeAgo"],
//         shareLink: json["shareLink"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "image": image,
//         "name": name,
//         "size": size,
//         "subscription": subscription,
//         "amount": amount,
//         "adminId": adminId,
//         "isOpen": isOpen,
//         "members": List<dynamic>.from(members.map((x) => x.toJson())),
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//         "about": about,
//         "posts": List<dynamic>.from(posts.map((x) => x)),
//         "products": List<dynamic>.from(products.map((x) => x.toJson())),
//         "terms_and_conditions": List<dynamic>.from(termsAndConditions.map((x) => x)),
//         "is_deleted": isDeleted,
//         "removed_members": List<dynamic>.from(removedMembers.map((x) => x.toJson())),
//         "whatsapp_group_link": whatsappGroupLink,
//         "banner_image": bannerImage,
//         "role": role,
//         "createdAtTimeAgo": createdAtTimeAgo,
//         "shareLink": shareLink,
//     };
// }

// class MemberElement {
//     MemberMember? member;
//     DateTime joinedDate;
//     String id;

//     MemberElement({
//         required this.member,
//         required this.joinedDate,
//         required this.id,
//     });

//     factory MemberElement.fromJson(Map<String, dynamic> json) => MemberElement(
//         member: json["member"] == null ? null : MemberMember.fromJson(json["member"]),
//         joinedDate: DateTime.parse(json["joined_date"]),
//         id: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "member": member?.toJson(),
//         "joined_date": joinedDate.toIso8601String(),
//         "_id": id,
//     };
// }

// class MemberMember {
//     String id;
//     String firstName;
//     String lastName;
//     String profilePicture;
//     String oneLinkId;

//     MemberMember({
//         required this.id,
//         required this.firstName,
//         required this.lastName,
//         required this.profilePicture,
//         required this.oneLinkId,
//     });

//     factory MemberMember.fromJson(Map<String, dynamic> json) => MemberMember(
//         id: json["_id"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         profilePicture: json["profilePicture"],
//         oneLinkId: json["oneLinkId"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "firstName": firstName,
//         "lastName": lastName,
//         "profilePicture": profilePicture,
//         "oneLinkId": oneLinkId,
//     };
// }

// class Product {
//     String name;
//     String description;
//     bool isFree;
//     String image;
//     List<String> purchasedBy;
//     List<String> urls;
//     String id;
//     int? amount;

//     Product({
//         required this.name,
//         required this.description,
//         required this.isFree,
//         required this.image,
//         required this.purchasedBy,
//         required this.urls,
//         required this.id,
//         this.amount,
//     });

//     factory Product.fromJson(Map<String, dynamic> json) => Product(
//         name: json["name"],
//         description: json["description"],
//         isFree: json["is_free"],
//         image: json["image"],
//         purchasedBy: List<String>.from(json["purchased_by"].map((x) => x)),
//         urls: List<String>.from(json["URLS"].map((x) => x)),
//         id: json["_id"],
//         amount: json["amount"],
//     );

//     Map<String, dynamic> toJson() => {
//         "name": name,
//         "description": description,
//         "is_free": isFree,
//         "image": image,
//         "purchased_by": List<dynamic>.from(purchasedBy.map((x) => x)),
//         "URLS": List<dynamic>.from(urls.map((x) => x)),
//         "_id": id,
//         "amount": amount,
//     };
// }

// class RemovedMember {
//     String member;
//     String? reason;
//     DateTime removedAt;
//     String removedBy;
//     String id;

//     RemovedMember({
//         required this.member,
//         this.reason,
//         required this.removedAt,
//         required this.removedBy,
//         required this.id,
//     });

//     factory RemovedMember.fromJson(Map<String, dynamic> json) => RemovedMember(
//         member: json["member"],
//         reason: json["reason"],
//         removedAt: DateTime.parse(json["removed_at"]),
//         removedBy: json["removed_by"],
//         id: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "member": member,
//         "reason": reason,
//         "removed_at": removedAt.toIso8601String(),
//         "removed_by": removedBy,
//         "_id": id,
//     };
// }

// To parse this JSON data, do
//
//     final myCommunitiesModel = myCommunitiesModelFromJson(jsonString);

import 'dart:convert';

MyCommunitiesModel myCommunitiesModelFromJson(String str) =>
    MyCommunitiesModel.fromJson(json.decode(str));

String myCommunitiesModelToJson(MyCommunitiesModel data) =>
    json.encode(data.toJson());

class MyCommunitiesModel {
  bool status;
  String message;
  List<MyCommunities> data;

  MyCommunitiesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MyCommunitiesModel.fromJson(Map<String, dynamic> json) =>
      MyCommunitiesModel(
        status: json["status"],
        message: json["message"],
        data: List<MyCommunities>.from(
            json["data"].map((x) => MyCommunities.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MyCommunities {
  String id;
  String community;
  String image;
  String size;
  String role;
  String createdAtTimeAgo;
  String shareLink;
  String members;

  MyCommunities({
    required this.id,
    required this.community,
    required this.image,
    required this.size,
    required this.role,
    required this.createdAtTimeAgo,
    required this.shareLink,
    required this.members,
  });

  factory MyCommunities.fromJson(Map<String, dynamic> json) => MyCommunities(
        id: json["_id"],
        community: json["community"],
        image: json["image"],
        size: json["size"],
        role: json["role"],
        createdAtTimeAgo: json["createdAtTimeAgo"],
        shareLink: json["shareLink"],
        members: json["members"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "community": community,
        "image": image,
        "size": size,
        "role": role,
        "createdAtTimeAgo": createdAtTimeAgo,
        "shareLink": shareLink,
        "members": members,
      };
}
