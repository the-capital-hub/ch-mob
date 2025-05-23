import 'dart:convert';

GetCommunityProductsAndMembersModel communityDataFromJson(String str) =>
    GetCommunityProductsAndMembersModel.fromJson(json.decode(str));

String communityDataToJson(GetCommunityProductsAndMembersModel data) =>
    json.encode(data.toJson());

class GetCommunityProductsAndMembersModel {
  bool status;
  String message;
  CommunityProductsAndMembers data;

  GetCommunityProductsAndMembersModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetCommunityProductsAndMembersModel.fromJson(
          Map<String, dynamic> json) =>
      GetCommunityProductsAndMembersModel(
        status: json["status"],
        message: json["message"],
        data: CommunityProductsAndMembers.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class CommunityProductsAndMembers {
  List<CommunityProduct> products;
  List<Member> members;

  CommunityProductsAndMembers({
    required this.products,
    required this.members,
  });

  factory CommunityProductsAndMembers.fromJson(Map<String, dynamic> json) =>
      CommunityProductsAndMembers(
        products: List<CommunityProduct>.from(
            json["products"].map((x) => CommunityProduct.fromJson(x))),
        members:
            List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
      };
}

class CommunityProduct {
  String name;
  String description;
  bool isFree;
  int? amount;
  String image;
  List<PurchasedBy> purchasedBy;
  List<String> urls;
  String id;
  bool isProductPurchased;
  String? productSharelink;

  CommunityProduct({
    required this.name,
    required this.description,
    required this.isFree,
    this.amount,
    required this.image,
    required this.purchasedBy,
    required this.urls,
    required this.id,
    required this.isProductPurchased,
    this.productSharelink,
  });

  factory CommunityProduct.fromJson(Map<String, dynamic> json) =>
      CommunityProduct(
        name: json["name"],
        description: json["description"],
        isFree: json["is_free"],
        amount: json["amount"],
        image: json["image"],
        purchasedBy: List<PurchasedBy>.from(
            json["purchased_by"].map((x) => PurchasedBy.fromJson(x))),
        urls: List<String>.from(json["URLS"].map((x) => x)),
        id: json["_id"],
        isProductPurchased: json["isProductPurchased"],
        productSharelink: json["product_shareLink"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "is_free": isFree,
        "amount": amount,
        "image": image,
        "purchased_by": List<dynamic>.from(purchasedBy.map((x) => x.toJson())),
        "URLS": List<dynamic>.from(urls.map((x) => x)),
        "_id": id,
        "isProductPurchased": isProductPurchased,
        "product_shareLink": productSharelink,
      };
}

class PurchasedBy {
  String firstName;
  String lastName;
  String userName;

  PurchasedBy({
    required this.firstName,
    required this.lastName,
    required this.userName,
  });

  factory PurchasedBy.fromJson(Map<String, dynamic> json) => PurchasedBy(
        firstName: json["firstName"],
        lastName: json["lastName"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "userName": userName,
      };
}

class Member {
  String id;
  String firstName;
  String lastName;
  String profilePicture;
  String? designation;
  String? company;
  String? location;
  String joinedDate;

  Member(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.profilePicture,
      this.designation,
      this.company,
      this.location,
      required this.joinedDate});

  factory Member.fromJson(Map<String, dynamic> json) => Member(
      id: json["_id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      profilePicture: json["profilePicture"],
      designation: json["designation"],
      company: json["company"],
      location: json["location"],
      joinedDate: json["joined_date"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture,
        "designation": designation,
        "company": company,
        "location": location,
        "joined_date": joinedDate
      };
}
