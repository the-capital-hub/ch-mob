// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  bool? status;
  String? message;
  ProfileData? data;

  ProfileModel({
    this.status,
    this.message,
    this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        message: json["message"],
        data: ProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class ProfileData {
  String? profilePicture;
  String? firstName;
  String? lastName;
  String? userName;
  String? designation;
  String? companyName;
  String? location;
  String? bio;
  String? education;
  String? experience;
  int? connectionsCount;
  int? followersCount;
  Milestone? milestoneProfile;
  Milestone? milestoneCompany;
  Milestone? milestoneOnelink;
  Milestone? milestoneDocuments;
  Milestone? milestonePosts;
  bool? isSubscribed;
  List<RecentConnection>? recentConnections;

  CompanyData? companyData;

  ProfileData({
    this.profilePicture,
    this.firstName,
    this.lastName,
    this.userName,
    this.designation,
    this.companyName,
    this.location,
    this.bio,
    this.education,
    this.experience,
    this.connectionsCount,
    this.followersCount,
    this.milestoneProfile,
    this.milestoneCompany,
    this.milestoneOnelink,
    this.milestoneDocuments,
    this.milestonePosts,
    this.isSubscribed,
    this.recentConnections,
    this.companyData,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        profilePicture: json["profilePicture"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        userName: json["userName"],
        designation: json["designation"],
        companyName: json["companyName"],
        location: json["location"],
        bio: json["bio"],
        education: json["education"],
        experience: json["experience"],
        connectionsCount: json["connectionsCount"],
        followersCount: json["followersCount"],
        isSubscribed: json["isSubscribed"],
        milestoneProfile: Milestone.fromJson(json["milestone_profile"]),
        milestoneCompany: Milestone.fromJson(json["milestone_company"]),
        milestoneOnelink: Milestone.fromJson(json["milestone_onelink"]),
        milestoneDocuments: Milestone.fromJson(json["milestone_documents"]),
        milestonePosts: Milestone.fromJson(json["milestone_posts"]),
        recentConnections: List<RecentConnection>.from(
            json["recentConnections"].map((x) => RecentConnection.fromJson(x))),
        companyData: CompanyData.fromJson(json["companyData"]),
      );

  Map<String, dynamic> toJson() => {
        "profilePicture": profilePicture,
        "firstName": firstName,
        "lastName": lastName,
        "userName": userName,
        "designation": designation,
        "companyName": companyName,
        "location": location,
        "bio": bio,
        "education": education,
        "experience": experience,
        "connectionsCount": connectionsCount,
        "followersCount": followersCount,
        "isSubscribed": isSubscribed,
        "recentConnections":
            List<dynamic>.from(recentConnections!.map((x) => x.toJson())),
        "companyData": companyData!.toJson(),
      };
}

class Milestone {
  String? name;
  int? completion;
  String? description;
  String? image;

  Milestone({
    this.name,
    this.completion,
    this.description,
    this.image,
  });

  factory Milestone.fromJson(Map<String, dynamic> json) => Milestone(
        name: json["name"],
        completion: json["completion"],
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "completion": completion,
        "description": description,
        "image": image,
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

class RecentConnection {
  String? firstName;
  String? lastName;
  String? profilePicture;
  String? designation;

  RecentConnection({
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.designation,
  });

  factory RecentConnection.fromJson(Map<String, dynamic> json) =>
      RecentConnection(
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePicture: json["profilePicture"],
        designation: json["designation"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture,
        "designation": designation,
      };
}
