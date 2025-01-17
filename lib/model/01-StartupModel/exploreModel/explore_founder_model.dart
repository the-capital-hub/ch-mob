// To parse this JSON data, do
//
//     final exploreFounderModel = exploreFounderModelFromJson(jsonString);

import 'dart:convert';

ExploreFounderModel exploreFounderModelFromJson(String str) =>
    ExploreFounderModel.fromJson(json.decode(str));

String exploreFounderModelToJson(ExploreFounderModel data) =>
    json.encode(data.toJson());

class ExploreFounderModel {
  bool? status;
  String? message;
  List<FounderExplore>? data;

  ExploreFounderModel({
    this.status,
    this.message,
    this.data,
  });

  factory ExploreFounderModel.fromJson(Map<String, dynamic> json) =>
      ExploreFounderModel(
        status: json["status"],
        message: json["message"],
        data: List<FounderExplore>.from(
            json["data"].map((x) => FounderExplore.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class FounderExplore {
  String? name;
  String? profilePicture;
  String? designation;
  String? company;
  String? location;
  int? startedAtDate;
  String? lastFunding;
  String? bio;
  String? education;
  String? experience;
  String? companyStage;
  String? companySector;
  String? description;
  List<SocialLink>? socialLinks;
  String? email;
  String? companyLogo;

  FounderExplore({
    this.name,
    this.profilePicture,
    this.designation,
    this.company,
    this.location,
    this.startedAtDate,
    this.lastFunding,
    this.bio,
    this.education,
    this.experience,
    this.companyStage,
    this.companySector,
    this.description,
    this.socialLinks,
    this.email,
    this.companyLogo,
  });

  factory FounderExplore.fromJson(Map<String, dynamic> json) => FounderExplore(
        name: json["name"],
        profilePicture: json["profilePicture"],
        designation: json["designation"],
        company: json["company"],
        location: json["location"],
        startedAtDate: json["startedAtDate"],
        lastFunding: json["lastFunding"],
        bio: json["bio"],
        education: json["education"],
        experience: json["experience"],
        companyStage: json["companyStage"],
        companySector: json["companySector"],
        description: json["description"],
        socialLinks: List<SocialLink>.from(
            json["socialLinks"].map((x) => SocialLink.fromJson(x))),
        email: json["email"],
        companyLogo: json["companyLogo"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "profilePicture": profilePicture,
        "designation": designation,
        "company": company,
        "location": location,
        "startedAtDate": startedAtDate,
        "lastFunding": lastFunding,
        "bio": bio,
        "education": education,
        "experience": experience,
        "companyStage": companyStage,
        "companySector": companySector,
        "description": description,
        "socialLinks": List<dynamic>.from(socialLinks!.map((x) => x.toJson())),
        "email": email,
        "companyLogo": companyLogo,
      };
}

class SocialLink {
  String? logo;
  String? name;
  String? link;

  SocialLink({
    this.name,
    this.logo,
    this.link,
  });

  factory SocialLink.fromJson(Map<String, dynamic> json) => SocialLink(
        logo: json["logo"],
        name: json["name"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "link": link,
      };
}
