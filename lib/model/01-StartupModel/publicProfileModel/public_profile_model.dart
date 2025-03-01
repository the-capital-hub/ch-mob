// To parse this JSON data, do
//
//     final publicProfileModel = publicProfileModelFromJson(jsonString);

import 'dart:convert';

PublicProfileModel publicProfileModelFromJson(String str) =>
    PublicProfileModel.fromJson(json.decode(str));

String publicProfileModelToJson(PublicProfileModel data) =>
    json.encode(data.toJson());

class PublicProfileModel {
  bool? success;
  PublicData? data;
  String? message;

  PublicProfileModel({
    this.success,
    this.data,
    this.message,
  });

  factory PublicProfileModel.fromJson(Map<String, dynamic> json) =>
      PublicProfileModel(
        success: json["success"],
        data: PublicData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
        "message": message,
      };
}

class PublicData {
  UserProfile? userProfile;
  CompanyData? companyData;
  UserEmail? userEmail;
  List<Post>? post;
  List<Event>? events;
  List<Community>? communities;
  PriorityDm? priorityDm;

  PublicData({
    this.userProfile,
    this.companyData,
    this.userEmail,
    this.post,
    this.events,
    this.communities,
    this.priorityDm,
  });

  factory PublicData.fromJson(Map<String, dynamic> json) => PublicData(
        userProfile: UserProfile.fromJson(json["userProfile"]),
        companyData: CompanyData.fromJson(json["companyData"]),
        userEmail: UserEmail.fromJson(json["userEmail"]),
        post: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
        events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
        communities: List<Community>.from(
            json["communities"].map((x) => Community.fromJson(x))),
        priorityDm: PriorityDm.fromJson(json["priorityDM"]),
      );

  Map<String, dynamic> toJson() => {
        "userProfile": userProfile!.toJson(),
        "companyData": companyData!.toJson(),
        "userEmail": userEmail!.toJson(),
        "post": List<dynamic>.from(post!.map((x) => x.toJson())),
        "events": List<dynamic>.from(events!.map((x) => x.toJson())),
        "communities": List<dynamic>.from(communities!.map((x) => x.toJson())),
        "priorityDM": priorityDm!.toJson(),
      };
}

class Community {
  String? id;
  String? community;
  String? amount;
  String? image;
  String? size;
  String? createdAtTimeAgo;
  String? shareLink;
  String? members;

  Community({
    this.id,
    this.community,
    this.amount,
    this.image,
    this.size,
    this.createdAtTimeAgo,
    this.shareLink,
    this.members,
  });

  factory Community.fromJson(Map<String, dynamic> json) => Community(
        id: json["_id"],
        community: json["community"],
        amount: json['amount'],
        image: json["image"],
        size: json["size"],
        createdAtTimeAgo: json["createdAt"],
        shareLink: json["shareLink"],
        members: json["members"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "community": community,
        "image": image,
        "size": size,
        "createdAtTimeAgo": createdAtTimeAgo,
        "shareLink": shareLink,
        "members": members,
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

class Event {
  String? id;
  bool? isActive;
  String? title;
  String? duration;
  String? price;
  String? discount;
  String? url;
  String? bookings;
  String? eventType;
  String? description;

  Event({
    this.id,
    this.isActive,
    this.title,
    this.duration,
    this.price,
    this.discount,
    this.url,
    this.bookings,
    this.eventType,
    this.description,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
      id: json["_id"],
      isActive: json["isActive"],
      title: json["title"],
      duration: json["duration"],
      price: json["price"],
      discount: json["discountedPrice"],
      url: json["url"],
      bookings: json["bookings"],
      eventType: json["eventType"],
      description: json['description']);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "isActive": isActive,
        "title": title,
        "duration": duration,
        "price": price,
        "discount": discount,
        "url": url,
        "bookings": bookings,
        "eventType": eventType,
      };
}

class Post {
  String? userProfilePicture;
  String? userDesignation;
  String? userFirstName;
  String? userLastName;
  String? userLocation;
  String? postId;
  String? description;
  List<String>? images;
  String? age;
  List<PollOption>? pollOptions;
  List<String>? myVotes;
  int? totalVotes;

  Post({
    this.userProfilePicture,
    this.userDesignation,
    this.userFirstName,
    this.userLastName,
    this.userLocation,
    this.postId,
    this.description,
    this.images,
    this.age,
    this.pollOptions,
    this.myVotes,
    this.totalVotes,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userProfilePicture: json["userProfilePicture"],
        userDesignation: json["userDesignation"],
        userFirstName: json["userFirstName"],
        userLastName: json["userLastName"],
        userLocation: json["userLocation"],
        postId: json["postId"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        age: json["age"],
        pollOptions: List<PollOption>.from(
            json["pollOptions"].map((x) => PollOption.fromJson(x))),
        myVotes: List<String>.from(json["myVotes"].map((x) => x)),
        totalVotes: json["totalVotes"],
      );

  Map<String, dynamic> toJson() => {
        "userProfilePicture": userProfilePicture,
        "userDesignation": userDesignation,
        "userFirstName": userFirstName,
        "userLastName": userLastName,
        "userLocation": userLocation,
        "postId": postId,
        "description": description,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "age": age,
        "pollOptions": List<dynamic>.from(pollOptions!.map((x) => x.toJson())),
        "myVotes": List<dynamic>.from(myVotes!.map((x) => x)),
        "totalVotes": totalVotes,
      };
}

class PollOption {
  String? id;
  String? option;
  int? numberOfVotes;
  bool? hasVoted;

  PollOption({
    this.id,
    this.option,
    this.numberOfVotes,
    this.hasVoted,
  });

  factory PollOption.fromJson(Map<String, dynamic> json) => PollOption(
        id: json["_id"],
        option: json["option"],
        numberOfVotes: json["numberOfVotes"],
        hasVoted: json["hasVoted"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "option": option,
        "numberOfVotes": numberOfVotes,
        "hasVoted": hasVoted,
      };
}

class PriorityDm {
  String? amount;
  String? title;
  String? rating;
  String? tag;
  String? description;

  PriorityDm({
    this.amount,
    this.title,
    this.rating,
    this.tag,
    this.description,
  });

  factory PriorityDm.fromJson(Map<String, dynamic> json) => PriorityDm(
        amount: json["amount"].toString(),
        title: json["title"],
        rating: json["rating"],
        tag: json["tag"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "title": title,
        "rating": rating,
        "tag": tag,
        "description": description,
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
  String? connectionStatus;
  String? totalExperience;
  String? companyLogo;
  String? connections;
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
    this.totalExperience,
    this.connectionStatus,
    this.companyLogo,
    this.connections,
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
        connectionStatus: json["connectionStatus"],
        totalExperience: json["totalExperience"],
        connections: json["connections"],
        companyLogo: json["companyLogo"],
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
        "linkedinUrl": linkedinUrl,
        "firstName": firstName,
        "lastName": lastName,
        "designation": designation,
        "companyName": companyName,
        "location": location,
        "bio": bio,
        "education": List<dynamic>.from(education!.map((x) => x.toJson())),
        "experience": List<dynamic>.from(experience!.map((x) => x.toJson())),
        "isSubscribed": isSubscribed,
      };
}

class Education {
  String? educationLogo;
  String? educationSchool;
  String? educationLocation;
  String? educationCourse;
  String? educationPassoutDate;
  String? educationDescription;

  Education({
    this.educationLogo,
    this.educationSchool,
    this.educationLocation,
    this.educationCourse,
    this.educationPassoutDate,
    this.educationDescription,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        educationLogo: json["educationLogo"],
        educationSchool: json["educationSchool"],
        educationLocation: json["educationLocation"],
        educationCourse: json["educationCourse"],
        educationPassoutDate: json["educationPassoutDate"].toString(),
        educationDescription: json["educationDescription"],
      );

  Map<String, dynamic> toJson() => {
        "educationLogo": educationLogo,
        "educationSchool": educationSchool,
        "educationLocation": educationLocation,
        "educationCourse": educationCourse,
        "educationPassoutDate": educationPassoutDate,
        "educationDescription": educationDescription,
      };
}

class Experience {
  String? companyLogo;
  String? companyName;
  String? companyLocation;
  String? companyRole;
  String? companyDescription;
  String? companyStartDate;
  String? companyEndDate;

  Experience({
    this.companyLogo,
    this.companyName,
    this.companyLocation,
    this.companyRole,
    this.companyDescription,
    this.companyStartDate,
    this.companyEndDate,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        companyLogo: json["companyLogo"],
        companyName: json["companyName"],
        companyLocation: json["companyLocation"],
        companyRole: json["companyRole"],
        companyDescription: json["companyDescription"],
        companyStartDate: json["companyStartDate"].toString(),
        companyEndDate: json["companyEndDate"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "companyLogo": companyLogo,
        "companyName": companyName,
        "companyLocation": companyLocation,
        "companyRole": companyRole,
        "companyDescription": companyDescription,
        "companyStartDate": companyStartDate,
        "companyEndDate": companyEndDate,
      };
}
