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
  String? companyName;
  String? location;
  String? logo;
  String? description;
  String? sector;
  String? startedAtDate;
  List<SocialLink>? socialLinks;
  String? stage;
  String? age;
  String? lastFunding;

  CompanyData({
    this.companyName,
    this.location,
    this.logo,
    this.description,
    this.sector,
    this.startedAtDate,
    this.socialLinks,
    this.stage,
    this.age,
    this.lastFunding,
  });

  factory CompanyData.fromJson(Map<String, dynamic> json) => CompanyData(
        companyName: json["companyName"],
        location: json["location"],
        logo: json["logo"],
        description: json["description"],
        sector: json["sector"],
        startedAtDate: json["startedAtDate"],
        socialLinks: json["socialLinks"] != null
            ? List<SocialLink>.from(
                json["socialLinks"].map((x) => SocialLink.fromJson(x)))
            : [],
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
        "socialLinks": List<dynamic>.from(socialLinks!.map((x) => x.toJson())),
        "stage": stage,
        "age": age,
        "lastFunding": lastFunding,
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

class UserEmail {
  String? email;
  bool? isAccessible;

  UserEmail({
    this.email,
    this.isAccessible,
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
  String? profilePicture;
  String? linkedinUrl;
  String? firstName;
  String? lastName;
  String? designation;
  String? companyName;
  String? location;
  String? bio;
  List<Education>? education;
  List<Experience>? experience;
  bool? isSubscribed;

  UserProfile({
    this.profilePicture,
    this.linkedinUrl,
    this.firstName,
    this.lastName,
    this.designation,
    this.companyName,
    this.location,
    this.bio,
    this.education,
    this.experience,
    this.isSubscribed,
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
        education: List<Education>.from(
            json["education"].map((x) => Education.fromJson(x))),
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
        "isSubscribed": isSubscribed,
      };
}

class Experience {
  String companyLogo;
  String companyName;
  String location;
  String role;
  String description;
  String startYear;
  String endYear;

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
        location: json["companyLocation"],
        role: json["companyRole"],
        description: json["companyDescription"],
        startYear: json["companyStartDate"].toString(),
        endYear: json["companyEndDate"].toString(),
      );
}

class Education {
  String educationLogo;
  String educationSchoolName;
  String educationLocation;
  String educationCourse;
  String educationPassYear;
  String educationDescription;

  Education({
    required this.educationLogo,
    required this.educationSchoolName,
    required this.educationLocation,
    required this.educationCourse,
    required this.educationDescription,
    required this.educationPassYear,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        educationLogo: json["educationLogo"],
        educationSchoolName: json["educationSchool"],
        educationLocation: json["educationLocation"],
        educationCourse: json["educationCourse"],
        educationPassYear: json["educationPassoutDate"],
        educationDescription: json["educationDescription"],
      );
}
