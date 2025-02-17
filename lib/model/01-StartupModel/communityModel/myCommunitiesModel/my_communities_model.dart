// To parse this JSON data, do
//
//     final myCommunitiesModel = myCommunitiesModelFromJson(jsonString);

import 'dart:convert';

MyCommunitiesModel myCommunitiesModelFromJson(String str) => MyCommunitiesModel.fromJson(json.decode(str));

String myCommunitiesModelToJson(MyCommunitiesModel data) => json.encode(data.toJson());

class MyCommunitiesModel {
    bool status;
    String message;
    List<MyCommunities> data;

    MyCommunitiesModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory MyCommunitiesModel.fromJson(Map<String, dynamic> json) => MyCommunitiesModel(
        status: json["status"],
        message: json["message"],
        data: List<MyCommunities>.from(json["data"].map((x) => MyCommunities.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class MyCommunities {
    String id;
    String name;
    String size;
    Subscription subscription;
    int? amount;
    AdminId adminId;
    bool isOpen;
    List<dynamic> posts;
    List<String> termsAndConditions;
    bool isDeleted;
    List<MemberElement> members;
    List<Product> products;
    List<RemovedMember> removedMembers;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String image;
    String? about;
    String? whatsappGroupLink;
    String? bannerImage;
    String role;
    String createdAtTimeAgo;
    String shareLink;

    MyCommunities({
        required this.id,
        required this.name,
        required this.size,
        required this.subscription,
        required this.amount,
        required this.adminId,
        required this.isOpen,
        required this.posts,
        required this.termsAndConditions,
        required this.isDeleted,
        required this.members,
        required this.products,
        required this.removedMembers,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.image,
        this.about,
        this.whatsappGroupLink,
        this.bannerImage,
        required this.role,
        required this.createdAtTimeAgo,
        required this.shareLink,
    });

    factory MyCommunities.fromJson(Map<String, dynamic> json) => MyCommunities(
        id: json["_id"],
        name: json["name"],
        size: json["size"],
        subscription: subscriptionValues.map[json["subscription"]]!,
        amount: json["amount"],
        adminId: adminIdValues.map[json["adminId"]]!,
        isOpen: json["isOpen"],
        posts: List<dynamic>.from(json["posts"].map((x) => x)),
        termsAndConditions: List<String>.from(json["terms_and_conditions"].map((x) => x)),
        isDeleted: json["is_deleted"],
        members: List<MemberElement>.from(json["members"].map((x) => MemberElement.fromJson(x))),
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
        removedMembers: List<RemovedMember>.from(json["removed_members"].map((x) => RemovedMember.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        image: json["image"],
        about: json["about"],
        whatsappGroupLink: json["whatsapp_group_link"],
        bannerImage: json["banner_image"],
        role: json["role"],
        createdAtTimeAgo: json["createdAtTimeAgo"],
        shareLink: json["shareLink"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "size": size,
        "subscription": subscriptionValues.reverse[subscription],
        "amount": amount,
        "adminId": adminIdValues.reverse[adminId],
        "isOpen": isOpen,
        "posts": List<dynamic>.from(posts.map((x) => x)),
        "terms_and_conditions": List<dynamic>.from(termsAndConditions.map((x) => x)),
        "is_deleted": isDeleted,
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "removed_members": List<dynamic>.from(removedMembers.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "image": image,
        "about": about,
        "whatsapp_group_link": whatsappGroupLink,
        "banner_image": bannerImage,
        "role": role,
        "createdAtTimeAgo": createdAtTimeAgo,
        "shareLink": shareLink,
    };
}

enum AdminId {
    THE_66823_FC5_E233_B21_ACCA0_B471,
    THE_671_C86508_A5567_ABE4_BCF18_B
}

final adminIdValues = EnumValues({
    "66823fc5e233b21acca0b471": AdminId.THE_66823_FC5_E233_B21_ACCA0_B471,
    "671c86508a5567abe4bcf18b": AdminId.THE_671_C86508_A5567_ABE4_BCF18_B
});

enum CreatedAtTimeAgo {
    ABOUT_1_MONTH_AGO,
    THE_9_DAYS_AGO
}

final createdAtTimeAgoValues = EnumValues({
    "about 1 month ago": CreatedAtTimeAgo.ABOUT_1_MONTH_AGO,
    "9 days ago": CreatedAtTimeAgo.THE_9_DAYS_AGO
});

class MemberElement {
    MemberMember member;
    DateTime joinedDate;
    String id;

    MemberElement({
        required this.member,
        required this.joinedDate,
        required this.id,
    });

    factory MemberElement.fromJson(Map<String, dynamic> json) => MemberElement(
        member: MemberMember.fromJson(json["member"]),
        joinedDate: DateTime.parse(json["joined_date"]),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "member": member.toJson(),
        "joined_date": joinedDate.toIso8601String(),
        "_id": id,
    };
}

class MemberMember {
    String id;
    String firstName;
    String lastName;
    String profilePicture;
    String oneLinkId;

    MemberMember({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.profilePicture,
        required this.oneLinkId,
    });

    factory MemberMember.fromJson(Map<String, dynamic> json) => MemberMember(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePicture: json["profilePicture"],
        oneLinkId: json["oneLinkId"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture,
        "oneLinkId": oneLinkId,
    };
}

class Product {
    String name;
    String description;
    bool isFree;
    int? amount;
    String image;
    List<String> purchasedBy;
    List<String> urls;
    String id;

    Product({
        required this.name,
        required this.description,
        required this.isFree,
        required this.amount,
        required this.image,
        required this.purchasedBy,
        required this.urls,
        required this.id,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        description: json["description"],
        isFree: json["is_free"],
        amount: json["amount"],
        image: json["image"],
        purchasedBy: List<String>.from(json["purchased_by"].map((x) => x)),
        urls: List<String>.from(json["URLS"].map((x) => x)),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "is_free": isFree,
        "amount": amount,
        "image": image,
        "purchased_by": List<dynamic>.from(purchasedBy.map((x) => x)),
        "URLS": List<dynamic>.from(urls.map((x) => x)),
        "_id": id,
    };
}

class RemovedMember {
    AdminId member;
    String reason;
    DateTime removedAt;
    AdminId removedBy;
    String id;

    RemovedMember({
        required this.member,
        required this.reason,
        required this.removedAt,
        required this.removedBy,
        required this.id,
    });

    factory RemovedMember.fromJson(Map<String, dynamic> json) => RemovedMember(
        member: adminIdValues.map[json["member"]]!,
        reason: json["reason"],
        removedAt: DateTime.parse(json["removed_at"]),
        removedBy: adminIdValues.map[json["removed_by"]]!,
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "member": adminIdValues.reverse[member],
        "reason": reason,
        "removed_at": removedAt.toIso8601String(),
        "removed_by": adminIdValues.reverse[removedBy],
        "_id": id,
    };
}

enum Role {
    MEMBER,
    OWNER
}

final roleValues = EnumValues({
    "member": Role.MEMBER,
    "owner": Role.OWNER
});

enum Subscription {
    FREE,
    PAID
}

final subscriptionValues = EnumValues({
    "free": Subscription.FREE,
    "paid": Subscription.PAID
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
