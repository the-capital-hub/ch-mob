// To parse this JSON data, do
//
//     final userExistingProductModel = userExistingProductModelFromJson(jsonString);

import 'dart:convert';

UserExistingProductModel userExistingProductModelFromJson(String str) =>
    UserExistingProductModel.fromJson(json.decode(str));

String userExistingProductModelToJson(UserExistingProductModel data) =>
    json.encode(data.toJson());

class UserExistingProductModel {
  bool? status;
  String? message;
  List<ExistingProduct>? data;

  UserExistingProductModel({
    this.status,
    this.message,
    this.data,
  });

  factory UserExistingProductModel.fromJson(Map<String, dynamic> json) =>
      UserExistingProductModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ExistingProduct>.from(
                json["data"]!.map((x) => ExistingProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ExistingProduct {
  String? existingProductId;
  String? title;
  String? tagline;
  String? aboutCompany;
  List<String>? coreValueProposition;
  String? firstComment;
  String? industry;
  String? productLink;
  String? twitterLink;
  String? instagramLink;
  String? linkedinLink;
  List<String>? tags;
  String? logo;
  String? banner;
  List<String>? productImages;
  List<Team>? team;
  String? pricing;
  dynamic priceAmount;
  String? priceType;
  String? promoCode;
  String? stage;
  String? panCard;
  String? aadharCard;
  String? pitchDeckDocument;
  bool? isPitchEnabled;

  ExistingProduct({
    this.existingProductId,
    this.title,
    this.tagline,
    this.aboutCompany,
    this.coreValueProposition,
    this.firstComment,
    this.industry,
    this.productLink,
    this.twitterLink,
    this.instagramLink,
    this.linkedinLink,
    this.tags,
    this.logo,
    this.banner,
    this.productImages,
    this.team,
    this.pricing,
    this.priceAmount,
    this.priceType,
    this.promoCode,
    this.stage,
    this.panCard,
    this.aadharCard,
    this.pitchDeckDocument,
    this.isPitchEnabled,
  });

  factory ExistingProduct.fromJson(Map<String, dynamic> json) =>
      ExistingProduct(
        existingProductId: json["existingProductId"],
        title: json["title"],
        tagline: json["tagline"],
        aboutCompany: json["aboutCompany"],
        coreValueProposition: json["coreValueProposition"] == null
            ? []
            : List<String>.from(json["coreValueProposition"]!.map((x) => x)),
        firstComment: json["firstComment"],
        industry: json["industry"],
        productLink: json["productLink"],
        twitterLink: json["twitterLink"],
        instagramLink: json["instagramLink"],
        linkedinLink: json["linkedinLink"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        logo: json["logo"],
        banner: json["banner"],
        productImages: json["productImages"] == null
            ? []
            : List<String>.from(json["productImages"]!.map((x) => x)),
        team: json["team"] == null
            ? []
            : List<Team>.from(json["team"]!.map((x) => Team.fromJson(x))),
        pricing: json["pricing"],
        priceAmount: json["priceAmount"],
        priceType: json["priceType"],
        promoCode: json["promoCode"],
        stage: json["stage"],
        panCard: json["panCard"],
        aadharCard: json["aadharCard"],
        pitchDeckDocument: json["pitchDeckDocument"],
        isPitchEnabled: json["isPitchEnabled"] ?? false,
        
      );

  Map<String, dynamic> toJson() => {
        "existingProductId": existingProductId,
        "title": title,
        "tagline": tagline,
        "aboutCompany": aboutCompany,
        "coreValueProposition": coreValueProposition == null
            ? []
            : List<dynamic>.from(coreValueProposition!.map((x) => x)),
        "firstComment": firstComment,
        "industry": industry,
        "productLink": productLink,
        "twitterLink": twitterLink,
        "instagramLink": instagramLink,
        "linkedinLink": linkedinLink,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "logo": logo,
        "banner": banner,
        "productImages": productImages == null
            ? []
            : List<dynamic>.from(productImages!.map((x) => x)),
        "team": team == null
            ? []
            : List<dynamic>.from(team!.map((x) => x.toJson())),
        "pricing": pricing,
        "priceAmount": priceAmount,
        "priceType": priceType,
        "promoCode": promoCode,
        "stage": stage,
      };
}

class Team {
  String? id;
  String? firstName;
  String? lastName;
  String? profilePicture;
  String? userName;
  String? designation;

  Team({
    this.id,
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.userName,
    this.designation,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePicture: json["profilePicture"],
        userName: json["userName"],
        designation: json["designation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture,
        "userName": userName,
        "designation": designation,
      };
}
