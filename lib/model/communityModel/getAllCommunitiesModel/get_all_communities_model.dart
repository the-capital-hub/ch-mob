// // To parse this JSON data, do
// //
// //     final getAllCommunitiesModel = getAllCommunitiesModelFromJson(jsonString);

// import 'dart:convert';

// GetAllCommunitiesModel getAllCommunitiesModelFromJson(String str) => GetAllCommunitiesModel.fromJson(json.decode(str));

// String getAllCommunitiesModelToJson(GetAllCommunitiesModel data) => json.encode(data.toJson());

// class GetAllCommunitiesModel {
//     bool status;
//     String message;
//     List<AllCommunities> data;

//     GetAllCommunitiesModel({
//         required this.status,
//         required this.message,
//         required this.data,
//     });

//     factory GetAllCommunitiesModel.fromJson(Map<String, dynamic> json) => GetAllCommunitiesModel(
//         status: json["status"],
//         message: json["message"],
//         data: List<AllCommunities>.from(json["data"].map((x) => AllCommunities.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }

// class AllCommunities {
//     String id;
//     String? image;
//     String name;
//     String size;
//     String subscription;
//     String amount;
//     String adminId;
//     bool isOpen;
//     List<Member> members;
//     DateTime createdAt;
//     DateTime updatedAt;
//     int v;
//     String? about;
//     List<dynamic> posts;
//     List<Product> products;
//     List<String> termsAndConditions;
//     bool isDeleted;
//     List<RemovedMember> removedMembers;
//     String? whatsappGroupLink;
//     String? bannerImage;
//     String isAbleToJoinTag;
//     String createdAtTimeAgo;

//     AllCommunities({
//         required this.id,
//         this.image,
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
//         this.about,
//         required this.posts,
//         required this.products,
//         required this.termsAndConditions,
//         required this.isDeleted,
//         required this.removedMembers,
//         this.whatsappGroupLink,
//         this.bannerImage,
//         required this.isAbleToJoinTag,
//         required this.createdAtTimeAgo,
//     });

//     factory AllCommunities.fromJson(Map<String, dynamic> json) => AllCommunities(
//         id: json["_id"],
//         image: json["image"],
//         name: json["name"],
//         size: json["size"],
//         subscription: json["subscription"],
//         amount: json["amount"],
//         adminId: json["adminId"],
//         isOpen: json["isOpen"],
//         members: List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
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
//         isAbleToJoinTag: json["isAbleToJoinTag"],
//         createdAtTimeAgo: json["createdAtTimeAgo"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "image": image,
//         "name": name,
//         "size": size,
//         "subscription": subscriptionValues.reverse[subscription],
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
//         "isAbleToJoinTag": isAbleToJoinTagValues.reverse[isAbleToJoinTag],
//         "createdAtTimeAgo": createdAtTimeAgo,
//     };
// }

// enum IsAbleToJoinTag {
//     ANYONE_CAN_JOIN,
//     CLOSED
// }

// final isAbleToJoinTagValues = EnumValues({
//     "Anyone can join": IsAbleToJoinTag.ANYONE_CAN_JOIN,
//     "Closed": IsAbleToJoinTag.CLOSED
// });

// class Member {
//     String member;
//     DateTime joinedDate;
//     String id;

//     Member({
//         required this.member,
//         required this.joinedDate,
//         required this.id,
//     });

//     factory Member.fromJson(Map<String, dynamic> json) => Member(
//         member: json["member"],
//         joinedDate: DateTime.parse(json["joined_date"]),
//         id: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "member": member,
//         "joined_date": joinedDate.toIso8601String(),
//         "_id": id,
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

// enum Subscription {
//     FREE
// }

// final subscriptionValues = EnumValues({
//     "free": Subscription.FREE
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     late Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//             reverseMap = map.map((k, v) => MapEntry(v, k));
//             return reverseMap;
//     }
// }

// To parse this JSON data, do
//
//     final getAllCommunitiesModel = getAllCommunitiesModelFromJson(jsonString);

// import 'dart:convert';

// GetAllCommunitiesModel getAllCommunitiesModelFromJson(String str) => GetAllCommunitiesModel.fromJson(json.decode(str));

// String getAllCommunitiesModelToJson(GetAllCommunitiesModel data) => json.encode(data.toJson());

// class GetAllCommunitiesModel {
//     bool status;
//     String message;
//     List<AllCommunities> data;

//     GetAllCommunitiesModel({
//         required this.status,
//         required this.message,
//         required this.data,
//     });

//     factory GetAllCommunitiesModel.fromJson(Map<String, dynamic> json) => GetAllCommunitiesModel(
//         status: json["status"],
//         message: json["message"],
//         data: List<AllCommunities>.from(json["data"].map((x) => AllCommunities.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }

// class AllCommunities {
//     String id;
//     String community;
//     String?  image;
//     String size;
//     String shareLink;
//     String members;
//     bool isCommunityMember;
//     Role role;
//     String isAbleToJoinTag;
//     String createdAtTimeAgo;
//     String amount;
//     bool isOpen;

//     AllCommunities({
//         required this.id,
//         required this.community,
//         this.image,
//         required this.size,
//         required this.shareLink,
//         required this.members,
//         required this.isCommunityMember,
//         required this.role,
//         required this.isAbleToJoinTag,
//         required this.createdAtTimeAgo,
//         required this.amount,
//         required this.isOpen
//     });

//     factory AllCommunities.fromJson(Map<String, dynamic> json) => AllCommunities(
//         id: json["_id"],
//         community: json["community"],
//         image: json["image"],
//         size: json["size"],
//         shareLink: json["shareLink"],
//         members: json["members"],
//         isCommunityMember: json["isCommunityMember"],
//         role: roleValues.map[json["role"]]!,
//         isAbleToJoinTag: json["isAbleToJoinTag"],
//         createdAtTimeAgo: json["createdAtTimeAgo"],
//         amount: json["amount"],
//         isOpen : json["isOpen"]
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "community": community,
//         "image": image,
//         "size": size,
//         "shareLink": shareLink,
//         "members": members,
//         "isCommunityMember": isCommunityMember,
//         "role": roleValues.reverse[role],
//         "isAbleToJoinTag": isAbleToJoinTagValues.reverse[isAbleToJoinTag],
//         "createdAtTimeAgo": createdAtTimeAgo,
//         "amount": amountValues.reverse[amount],
//         "isOpen": isOpen
//     };
// }

// enum Amount {
//     FREE_TO_JOIN,
//     RS_700_SUBSCRIPTION
// }

// final amountValues = EnumValues({
//     "Free to join": Amount.FREE_TO_JOIN,
//     "Rs 700 Subscription": Amount.RS_700_SUBSCRIPTION
// });

// enum IsAbleToJoinTag {
//     ANYONE_CAN_JOIN,
//     CLOSED
// }

// final isAbleToJoinTagValues = EnumValues({
//     "Anyone can join": IsAbleToJoinTag.ANYONE_CAN_JOIN,
//     "Closed": IsAbleToJoinTag.CLOSED
// });

// enum Role {
//     NONE
// }

// final roleValues = EnumValues({
//     "None": Role.NONE
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     late Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//             reverseMap = map.map((k, v) => MapEntry(v, k));
//             return reverseMap;
//     }
// }

// To parse this JSON data, do
//
//     final getAllCommunitiesModel = getAllCommunitiesModelFromJson(jsonString);

import 'dart:convert';

GetAllCommunitiesModel getAllCommunitiesModelFromJson(String str) =>
    GetAllCommunitiesModel.fromJson(json.decode(str));

String getAllCommunitiesModelToJson(GetAllCommunitiesModel data) =>
    json.encode(data.toJson());

class GetAllCommunitiesModel {
  bool status;
  String message;
  List<AllCommunities> data;

  GetAllCommunitiesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetAllCommunitiesModel.fromJson(Map<String, dynamic> json) =>
      GetAllCommunitiesModel(
        status: json["status"],
        message: json["message"],
        data: List<AllCommunities>.from(
            json["data"].map((x) => AllCommunities.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AllCommunities {
  String id;
  String community;
  String image;
  String size;
  String shareLink;
  String members;
  bool isCommunityMember;
  String role;
  String isAbleToJoinTag;
  bool isOpen;
  String createdAtTimeAgo;
  String amount;
  String paymentPrice;

  AllCommunities({
    required this.id,
    required this.community,
    required this.image,
    required this.size,
    required this.shareLink,
    required this.members,
    required this.isCommunityMember,
    required this.role,
    required this.isAbleToJoinTag,
    required this.isOpen,
    required this.createdAtTimeAgo,
    required this.amount,
    required this.paymentPrice,
  });

  factory AllCommunities.fromJson(Map<String, dynamic> json) => AllCommunities(
        id: json["_id"],
        community: json["community"],
        image: json["image"],
        size: json["size"],
        shareLink: json["shareLink"],
        members: json["members"],
        isCommunityMember: json["isCommunityMember"],
        role: json["role"],
        isAbleToJoinTag: json["isAbleToJoinTag"],
        isOpen: json["isOpen"],
        createdAtTimeAgo: json["createdAtTimeAgo"],
        amount: json["amount"],
        paymentPrice: json["paymentPrice"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "community": community,
        "image": image,
        "size": size,
        "shareLink": shareLink,
        "members": members,
        "isCommunityMember": isCommunityMember,
        "role": role,
        "isAbleToJoinTag": isAbleToJoinTag,
        "isOpen": isOpen,
        "createdAtTimeAgo": createdAtTimeAgo,
        "amount": amount,
      };
}

enum Amount { FREE_TO_JOIN, RS_700_SUBSCRIPTION }

final amountValues = EnumValues({
  "Free to join": Amount.FREE_TO_JOIN,
  "Rs 700 Subscription": Amount.RS_700_SUBSCRIPTION
});

enum IsAbleToJoinTag { ANYONE_CAN_JOIN, CLOSED }

final isAbleToJoinTagValues = EnumValues({
  "Anyone can join": IsAbleToJoinTag.ANYONE_CAN_JOIN,
  "Closed": IsAbleToJoinTag.CLOSED
});

enum Role { ADMIN, NONE }

final roleValues = EnumValues({"Admin": Role.ADMIN, "None": Role.NONE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
