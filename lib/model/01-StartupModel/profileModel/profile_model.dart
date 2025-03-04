// // To parse this JSON data, do
// //
// //     final profileModel = profileModelFromJson(jsonString);

// import 'dart:convert';

// ProfileModel profileModelFromJson(String str) =>
//     ProfileModel.fromJson(json.decode(str));

// String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

// class ProfileModel {
//   bool? status;
//   String? message;
//   ProfileData? data;

//   ProfileModel({
//     this.status,
//     this.message,
//     this.data,
//   });

//   factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
//         status: json["status"],
//         message: json["message"],
//         data: ProfileData.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data!.toJson(),
//       };
// }

// class ProfileData {
//   String? profilePicture;
//   String? firstName;
//   String? lastName;
//   String? userName;
//   String? designation;
//   String? companyName;
//   String? location;
//   String? bio;
//   List<Education>? education;
//   List<Experience>? experience;
//   int? connectionsCount;
//   int? followersCount;
//   Milestone? milestoneProfile;
//   Milestone? milestoneCompany;
//   Milestone? milestoneOnelink;
//   Milestone? milestoneDocuments;
//   Milestone? milestonePosts;
//   bool? isSubscribed;
//   List<RecentConnection>? recentConnections;

//   CompanyData? companyData;

//   ProfileData({
//     this.profilePicture,
//     this.firstName,
//     this.lastName,
//     this.userName,
//     this.designation,
//     this.companyName,
//     this.location,
//     this.bio,
//     this.education,
//     this.experience,
//     this.connectionsCount,
//     this.followersCount,
//     this.milestoneProfile,
//     this.milestoneCompany,
//     this.milestoneOnelink,
//     this.milestoneDocuments,
//     this.milestonePosts,
//     this.isSubscribed,
//     this.recentConnections,
//     this.companyData,
//   });

//   factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
//         profilePicture: json["profilePicture"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         userName: json["userName"],
//         designation: json["designation"],
//         companyName: json["companyName"],
//         location: json["location"],
//         bio: json["bio"],
//         education: List<Education>.from(
//             json["education"].map((x) => Education.fromJson(x))),
//         experience: List<Experience>.from(
//             json["experience"].map((x) => Experience.fromJson(x))),
//         connectionsCount: json["connectionsCount"],
//         followersCount: json["followersCount"],
//         isSubscribed: json["isSubscribed"],
//         milestoneProfile: Milestone.fromJson(json["milestone_profile"]),
//         milestoneCompany: Milestone.fromJson(json["milestone_company"]),
//         milestoneOnelink: Milestone.fromJson(json["milestone_onelink"]),
//         milestoneDocuments: Milestone.fromJson(json["milestone_documents"]),
//         milestonePosts: Milestone.fromJson(json["milestone_posts"]),
//         recentConnections: List<RecentConnection>.from(
//             json["recentConnections"].map((x) => RecentConnection.fromJson(x))),
//         companyData: CompanyData.fromJson(json["companyData"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "profilePicture": profilePicture,
//         "firstName": firstName,
//         "lastName": lastName,
//         "userName": userName,
//         "designation": designation,
//         "companyName": companyName,
//         "location": location,
//         "bio": bio,
//         "education": education,
//         "experience": experience,
//         "connectionsCount": connectionsCount,
//         "followersCount": followersCount,
//         "isSubscribed": isSubscribed,
//         "recentConnections":
//             List<dynamic>.from(recentConnections!.map((x) => x.toJson())),
//         "companyData": companyData!.toJson(),
//       };
// }

// class Experience {
//   String companyLogo;
//   String companyName;
//   String location;
//   String role;
//   String description;
//   String startYear;
//   String endYear;

//   Experience({
//     required this.companyLogo,
//     required this.companyName,
//     required this.location,
//     required this.role,
//     required this.description,
//     required this.startYear,
//     required this.endYear,
//   });

//   factory Experience.fromJson(Map<String, dynamic> json) => Experience(
//         companyLogo: json["companyLogo"],
//         companyName: json["companyName"],
//         location: json["companyLocation"],
//         role: json["companyRole"],
//         description: json["companyDescription"],
//         startYear: json["companyStartDate"].toString(),
//         endYear: json["companyEndDate"].toString(),
//       );
// }

// class Education {
//   String educationLogo;
//   String educationSchoolName;
//   String educationLocation;
//   String educationCourse;
//   String educationPassYear;
//   String educationDescription;

//   Education({
//     required this.educationLogo,
//     required this.educationSchoolName,
//     required this.educationLocation,
//     required this.educationCourse,
//     required this.educationDescription,
//     required this.educationPassYear,
//   });

//   factory Education.fromJson(Map<String, dynamic> json) => Education(
//         educationLogo: json["educationLogo"],
//         educationSchoolName: json["educationSchool"],
//         educationLocation: json["educationLocation"],
//         educationCourse: json["educationCourse"],
//         educationPassYear: json["educationPassoutDate"].toString(),
//         educationDescription: json["educationDescription"],
//       );
// }

// class Milestone {
//   String? name;
//   int? completion;
//   String? description;
//   String? image;

//   Milestone({
//     this.name,
//     this.completion,
//     this.description,
//     this.image,
//   });

//   factory Milestone.fromJson(Map<String, dynamic> json) => Milestone(
//         name: json["name"],
//         completion: json["completion"],
//         description: json["description"],
//         image: json["image"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "completion": completion,
//         "description": description,
//         "image": image,
//       };
// }

// class CompanyData {
//   String? companyName;
//   String? location;
//   String? logo;
//   String? description;
//   String? sector;
//   String? startedAtDate;
//   List<SocialLink>? socialLinks;
//   String? stage;
//   String? age;
//   String? lastFunding;

//   CompanyData({
//     this.companyName,
//     this.location,
//     this.logo,
//     this.description,
//     this.sector,
//     this.startedAtDate,
//     this.socialLinks,
//     this.stage,
//     this.age,
//     this.lastFunding,
//   });

//   factory CompanyData.fromJson(Map<String, dynamic> json) => CompanyData(
//         companyName: json["companyName"],
//         location: json["location"],
//         logo: json["logo"],
//         description: json["description"],
//         sector: json["sector"],
//         startedAtDate: json["startedAtDate"],
//         socialLinks: List<SocialLink>.from(
//             json["socialLinks"].map((x) => SocialLink.fromJson(x))),
//         stage: json["stage"],
//         age: json["age"],
//         lastFunding: json["lastFunding"],
//       );

//   Map<String, dynamic> toJson() => {
//         "companyName": companyName,
//         "location": location,
//         "logo": logo,
//         "description": description,
//         "sector": sector,
//         "startedAtDate": startedAtDate,
//         "socialLinks": List<dynamic>.from(socialLinks!.map((x) => x.toJson())),
//         "stage": stage,
//         "age": age,
//         "lastFunding": lastFunding,
//       };
// }

// class SocialLink {
//   String? name;
//   String? link;
//   String? logo;

//   SocialLink({
//     this.name,
//     this.link,
//     this.logo,
//   });

//   factory SocialLink.fromJson(Map<String, dynamic> json) => SocialLink(
//         name: json["name"],
//         link: json["link"],
//         logo: json["logo"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "link": link,
//         "logo": logo,
//       };
// }

// class RecentConnection {
//   String? firstName;
//   String? lastName;
//   String? profilePicture;
//   String? designation;

//   RecentConnection({
//     this.firstName,
//     this.lastName,
//     this.profilePicture,
//     this.designation,
//   });

//   factory RecentConnection.fromJson(Map<String, dynamic> json) =>
//       RecentConnection(
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         profilePicture: json["profilePicture"],
//         designation: json["designation"],
//       );

//   Map<String, dynamic> toJson() => {
//         "firstName": firstName,
//         "lastName": lastName,
//         "profilePicture": profilePicture,
//         "designation": designation,
//       };
// }
// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  bool status;
  String message;
  ProfileData data;

  ProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        message: json["message"],
        data: ProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class ProfileData {
  User? user;
  Banner? banner;

  ProfileData({
    this.user,
    this.banner,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        user: User.fromJson(json["user"]),
        banner: Banner.fromJson(json["banner"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "banner": banner!.toJson(),
      };
}

class Banner {
  bool isPasswordSet;
  String profileCompletionPercentage;
  String companyCompletionPercentage;
  bool isProfileCompleted;
  bool isCompanyAdded;

  Banner({
    required this.isPasswordSet,
    required this.profileCompletionPercentage,
    required this.companyCompletionPercentage,
    required this.isProfileCompleted,
    required this.isCompanyAdded,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        isPasswordSet: json["isPasswordSet"],
        profileCompletionPercentage: json["profileCompletionPercentage"],
        companyCompletionPercentage: json["companyCompletionPercentage"],
        isProfileCompleted: json["isProfileCompleted"],
        isCompanyAdded: json["isCompanyAdded"],
      );

  Map<String, dynamic> toJson() => {
        "isPasswordSet": isPasswordSet,
        "profileCompletionPercentage": profileCompletionPercentage,
        "companyCompletionPercentage": companyCompletionPercentage,
        "isProfileCompleted": isProfileCompleted,
        "isCompanyAdded": isCompanyAdded,
      };
}

class User {
  String profilePicture;
  String firstName;
  String lastName;
  String userName;
  String designation;
  String companyName;
  String location;
  String bio;
  List<Education>? education;
  List<Experience>? experience;
  int connectionsCount;
  int followersCount;
  bool isSubscribed;
  List<RecentConnection>? recentConnections;
  Milestone milestoneProfile;
  Milestone milestoneCompany;
  Milestone milestoneOnelink;
  Milestone milestoneDocuments;
  Milestone milestonePosts;
  CompanyData companyData;
  TopVoice topVoice;

  User(
      {required this.profilePicture,
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.designation,
      required this.companyName,
      required this.location,
      required this.bio,
      this.education,
      this.experience,
      required this.connectionsCount,
      required this.followersCount,
      required this.isSubscribed,
      required this.recentConnections,
      required this.milestoneProfile,
      required this.milestoneCompany,
      required this.milestoneOnelink,
      required this.milestoneDocuments,
      required this.milestonePosts,
      required this.companyData,
      required this.topVoice});

  factory User.fromJson(Map<String, dynamic> json) => User(
        profilePicture: json["profilePicture"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        userName: json["userName"],
        designation: json["designation"],
        companyName: json["companyName"],
        location: json["location"],
        bio: json["bio"],
        education: List<Education>.from(
            json["education"].map((x) => Education.fromJson(x))),
        experience: List<Experience>.from(
            json["experience"].map((x) => Experience.fromJson(x))),
        connectionsCount: json["connectionsCount"],
        followersCount: json["followersCount"],
        isSubscribed: json["isSubscribed"],
        recentConnections: List<RecentConnection>.from(
            json["recentConnections"].map((x) => RecentConnection.fromJson(x))),
        milestoneProfile: Milestone.fromJson(json["milestone_profile"]),
        milestoneCompany: Milestone.fromJson(json["milestone_company"]),
        milestoneOnelink: Milestone.fromJson(json["milestone_onelink"]),
        milestoneDocuments: Milestone.fromJson(json["milestone_documents"]),
        milestonePosts: Milestone.fromJson(json["milestone_posts"]),
        companyData: CompanyData.fromJson(json["companyData"]),
        topVoice: TopVoice.fromJson(json["topVoice"]),
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
        "education": List<dynamic>.from(education!.map((x) => x)),
        "experience": List<dynamic>.from(experience!.map((x) => x)),
        "connectionsCount": connectionsCount,
        "followersCount": followersCount,
        "isSubscribed": isSubscribed,
        "recentConnections":
            List<dynamic>.from(recentConnections!.map((x) => x)),
        "milestone_profile": milestoneProfile.toJson(),
        "milestone_company": milestoneCompany.toJson(),
        "milestone_onelink": milestoneOnelink.toJson(),
        "milestone_documents": milestoneDocuments.toJson(),
        "milestone_posts": milestonePosts.toJson(),
        "companyData": companyData.toJson(),
        "topVoice": topVoice.toJson(),
      };
}

class CompanyData {
  String companyName;
  String location;
  String logo;
  String description;
  String sector;
  String industry;
  String startedAtDate;
  List<dynamic> socialLinks;
  String stage;
  String age;
  String lastFunding;

  CompanyData({
    required this.companyName,
    required this.location,
    required this.logo,
    required this.description,
    required this.sector,
    required this.industry,
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
        industry: json["industry"],
        startedAtDate: json["startedAtDate"],
        socialLinks: List<dynamic>.from(json["socialLinks"].map((x) => x)),
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
        "industry": industry,
        "startedAtDate": startedAtDate,
        "socialLinks": List<dynamic>.from(socialLinks.map((x) => x)),
        "stage": stage,
        "age": age,
        "lastFunding": lastFunding,
      };
}

class Milestone {
  String name;
  int completion;
  String description;
  String image;

  Milestone({
    required this.name,
    required this.completion,
    required this.description,
    required this.image,
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
        educationPassYear: json["educationPassoutDate"].toString(),
        educationDescription: json["educationDescription"],
      );
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

class TopVoice {
  String? description;
  double? postsCount;

  TopVoice({
    this.description,
    this.postsCount,
  });

  factory TopVoice.fromJson(Map<String, dynamic> json) => TopVoice(
        description: json["description"],
        postsCount: json["postsCount"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "postsCount": postsCount,
      };
}
