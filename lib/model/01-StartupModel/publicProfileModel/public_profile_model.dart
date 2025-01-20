// To parse this JSON data, do
//
//     final publicProfileModel = publicProfileModelFromJson(jsonString);

import 'dart:convert';

PublicProfileModel publicProfileModelFromJson(String str) =>
    PublicProfileModel.fromJson(json.decode(str));

String publicProfileModelToJson(PublicProfileModel data) =>
    json.encode(data.toJson());

class PublicProfileModel {
  bool status;
  String message;
  PublicData data;

  PublicProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PublicProfileModel.fromJson(Map<String, dynamic> json) =>
      PublicProfileModel(
        status: json["status"],
        message: json["message"],
        data: PublicData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class PublicData {
  UserProfile? userProfile;
  CompanyData? companyData;
  UserEmail? userEmail;

  PublicData({
    this.userProfile,
    this.companyData,
    this.userEmail,
  });

  factory PublicData.fromJson(Map<String, dynamic> json) => PublicData(
        userProfile: UserProfile.fromJson(json["userProfile"]),
        companyData: CompanyData.fromJson(json["companyData"]),
        userEmail: UserEmail.fromJson(json["userEmail"]),
      );

  Map<String, dynamic> toJson() => {
        "userProfile": userProfile!.toJson(),
        "companyData": companyData!.toJson(),
        "userEmail": userEmail!.toJson(),
      };
}

class CompanyData {
  String companyName;
  String location;
  String logo;
  String description;
  String sector;
  String startedAtDate;
  List<SocialLink> socialLinks;
  String stage;
  String age;
  String lastFunding;

  CompanyData({
    required this.companyName,
    required this.location,
    required this.logo,
    required this.description,
    required this.sector,
    required this.startedAtDate,
    required this.socialLinks,
    required this.stage,
    required this.age,
    required this.lastFunding,
  });

  factory CompanyData.fromJson(Map<String, dynamic> json) => CompanyData(
        companyName: json["companyName"],
        location: json["location"],
        logo: json["logo"],
        description: json["description"],
        sector: json["sector"],
        startedAtDate: json["startedAtDate"],
        socialLinks: List<SocialLink>.from(
            json["socialLinks"].map((x) => SocialLink.fromJson(x))),
        stage: json["stage"],
        age: json["age"],
        lastFunding: json["lastFunding"],
      );

  Map<String, dynamic> toJson() => {
        "companyName": companyName,
        "location": location,
        "logo": logo,
        "description": description,
        "sector": sector,
        "startedAtDate": startedAtDate,
        "socialLinks": List<dynamic>.from(socialLinks.map((x) => x.toJson())),
        "stage": stage,
        "age": age,
        "lastFunding": lastFunding,
      };
}

class SocialLink {
  String name;
  String link;
  String logo;

  SocialLink({
    required this.name,
    required this.link,
    required this.logo,
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

class UserEmail {
  String email;
  bool isAccessible;

  UserEmail({
    required this.email,
    required this.isAccessible,
  });

  factory UserEmail.fromJson(Map<String, dynamic> json) => UserEmail(
        email: json["email"],
        isAccessible: json["isAccessible"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "isAccessible": isAccessible,
      };
}

class UserProfile {
  String profilePicture;
  String linkedinUrl;
  String firstName;
  String lastName;
  String designation;
  String companyName;
  String location;
  String bio;
  String education;
  List<Experience> experience;
  bool isSubscribed;

  UserProfile({
    required this.profilePicture,
    required this.linkedinUrl,
    required this.firstName,
    required this.lastName,
    required this.designation,
    required this.companyName,
    required this.location,
    required this.bio,
    required this.education,
    required this.experience,
    required this.isSubscribed,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        profilePicture: json["profilePicture"],
        linkedinUrl: json["linkedinUrl"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        designation: json["designation"],
        companyName: json["companyName"],
        location: json["location"],
        bio: json["bio"],
        education: json["education"],
        experience: List<Experience>.from(
            json["experience"].map((x) => Experience.fromJson(x))),
        isSubscribed: json["isSubscribed"],
      );

  Map<String, dynamic> toJson() => {
        "profilePicture": profilePicture,
        "firstName": firstName,
        "lastName": lastName,
        "designation": designation,
        "companyName": companyName,
        "location": location,
        "bio": bio,
        "education": education,
        "experience": List<dynamic>.from(experience.map((x) => x.toJson())),
        "isSubscribed": isSubscribed,
      };
}

class Experience {
  String companyLogo;
  String companyName;
  String location;
  String role;
  String description;
  int startYear;
  int endYear;

  Experience({
    required this.companyLogo,
    required this.companyName,
    required this.location,
    required this.role,
    required this.description,
    required this.startYear,
    required this.endYear,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        companyLogo: json["companyLogo"],
        companyName: json["companyName"],
        location: json["location"],
        role: json["role"],
        description: json["description"],
        startYear: json["startYear"],
        endYear: json["endYear"],
      );

  Map<String, dynamic> toJson() => {
        "companyLogo": companyLogo,
        "companyName": companyName,
        "location": location,
        "role": role,
        "description": description,
        "startYear": startYear,
        "endYear": endYear,
      };
}
