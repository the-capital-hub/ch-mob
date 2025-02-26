import 'dart:convert';

GetCommunityProductsAndMembersModel communityDataFromJson(String str) => GetCommunityProductsAndMembersModel.fromJson(json.decode(str));

String communityDataToJson(GetCommunityProductsAndMembersModel data) => json.encode(data.toJson());

class GetCommunityProductsAndMembersModel {
  bool status;
  String message;
  CommunityProductsAndMembers data;

  GetCommunityProductsAndMembersModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetCommunityProductsAndMembersModel.fromJson(Map<String, dynamic> json) => GetCommunityProductsAndMembersModel(
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
  List<Product> products;
  List<Member> members;

  CommunityProductsAndMembers({
    required this.products,
    required this.members,
  });

  factory CommunityProductsAndMembers.fromJson(Map<String, dynamic> json) => CommunityProductsAndMembers(
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
        members: List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
      };
}

class Product {
  String name;
  String description;
  bool isFree;
  int? amount;
  String image;
  List<PurchasedBy> purchasedBy;
  List<String> urls;
  String id;

  Product({
    required this.name,
    required this.description,
    required this.isFree,
    this.amount,
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
        purchasedBy: List<PurchasedBy>.from(json["purchased_by"].map((x) => PurchasedBy.fromJson(x))),
        urls: List<String>.from(json["URLS"].map((x) => x)),
        id: json["_id"],
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
  String firstName;
  String lastName;
  String profilePicture;
  String? designation;
  String? company;
  String? location;
  String joinedDate;

  Member({
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
    this.designation,
    this.company,
    this.location,
    required this.joinedDate
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePicture: json["profilePicture"],
        designation: json["designation"],
        company: json["company"],
        location: json["location"],
        joinedDate: json["joined_date"]
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture,
        "designation": designation,
        "company": company,
        "location": location,
        "joined_date": joinedDate
      };
}
