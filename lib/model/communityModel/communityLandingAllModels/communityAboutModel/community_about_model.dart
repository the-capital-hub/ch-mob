// // To parse this JSON data, do
// //
// //     final getAboutCommunityModel = getAboutCommunityModelFromJson(jsonString);

// import 'dart:convert';

// GetAboutCommunityModel getAboutCommunityModelFromJson(String str) => GetAboutCommunityModel.fromJson(json.decode(str));

// String getAboutCommunityModelToJson(GetAboutCommunityModel data) => json.encode(data.toJson());

// class GetAboutCommunityModel {
//     bool status;
//     String message;
//     AboutCommunity data;

//     GetAboutCommunityModel({
//         required this.status,
//         required this.message,
//         required this.data,
//     });

//     factory GetAboutCommunityModel.fromJson(Map<String, dynamic> json) => GetAboutCommunityModel(
//         status: json["status"],
//         message: json["message"],
//         data: AboutCommunity.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data.toJson(),
//     };
// }

// class AboutCommunity {
//     Community community;
//     Admin admin;
//     List<Product> products;
//     List<Post> posts;
//     List<Event> events;

//     AboutCommunity({
//         required this.community,
//         required this.admin,
//         required this.products,
//         required this.posts,
//         required this.events,
//     });

//     factory AboutCommunity.fromJson(Map<String, dynamic> json) => AboutCommunity(
//         community: Community.fromJson(json["community"]),
//         admin: Admin.fromJson(json["admin"]),
//         products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
//         posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
//         events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "community": community.toJson(),
//         "admin": admin.toJson(),
//         "products": List<dynamic>.from(products.map((x) => x.toJson())),
//         "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
//         "events": List<dynamic>.from(events.map((x) => x.toJson())),
//     };
// }

// class Admin {
//     String firstName;
//     String lastName;
//     String profilePicture;
//     String designation;
//     String bio;
//     String company;
//     String location;

//     Admin({
//         required this.firstName,
//         required this.lastName,
//         required this.profilePicture,
//         required this.designation,
//         required this.bio,
//         required this.company,
//         required this.location,
//     });

//     factory Admin.fromJson(Map<String, dynamic> json) => Admin(
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         profilePicture: json["profilePicture"],
//         designation: json["designation"],
//         bio: json["bio"],
//         company: json["company"],
//         location: json["location"],
//     );

//     Map<String, dynamic> toJson() => {
//         "firstName": firstName,
//         "lastName": lastName,
//         "profilePicture": profilePicture,
//         "designation": designation,
//         "bio": bio,
//         "company": company,
//         "location": location,
//     };
// }

// class Community {
//     String name;
//     String image;
//     String about;
//     List<String> termsAndConditions;
//     String whatsappGroupLink;
//     bool isOpen;
//     int amount;
//     String communitySize;
//     String subscription;
//     String shareLink;

//     Community({
//         required this.name,
//         required this.image,
//         required this.about,
//         required this.termsAndConditions,
//         required this.whatsappGroupLink,
//         required this.isOpen,
//         required this.amount,
//         required this.communitySize,
//         required this.subscription,
//         required this.shareLink,
//     });

//     factory Community.fromJson(Map<String, dynamic> json) => Community(
//         name: json["name"],
//         image: json["image"],
//         about: json["about"],
//         termsAndConditions: List<String>.from(json["terms_and_conditions"].map((x) => x)),
//         whatsappGroupLink: json["whatsapp_group_link"],
//         isOpen: json["isOpen"],
//         amount: json["amount"],
//         communitySize: json["communitySize"],
//         subscription: json["subscription"],
//         shareLink: json["shareLink"],
//     );

//     Map<String, dynamic> toJson() => {
//         "name": name,
//         "image": image,
//         "about": about,
//         "terms_and_conditions": List<dynamic>.from(termsAndConditions.map((x) => x)),
//         "whatsapp_group_link": whatsappGroupLink,
//         "isOpen": isOpen,
//         "amount": amount,
//         "communitySize": communitySize,
//         "subscription": subscription,
//         "shareLink": shareLink,
//     };
// }

// class Event {
//     String id;
//     String title;
//     String description;
//     String date;
//     String startTime;
//     String endTime;
//     int duration;
//     int price;
//     int discount;
//     EventUser user;

//     Event({
//         required this.id,
//         required this.title,
//         required this.description,
//         required this.date,
//         required this.startTime,
//         required this.endTime,
//         required this.duration,
//         required this.price,
//         required this.discount,
//         required this.user,
//     });

//     factory Event.fromJson(Map<String, dynamic> json) => Event(
//         id: json["_id"],
//         title: json["title"],
//         description: json["description"],
//         date: json["date"],
//         startTime: json["startTime"],
//         endTime: json["endTime"],
//         duration: json["duration"],
//         price: json["price"],
//         discount: json["discount"],
//         user: EventUser.fromJson(json["user"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "title": title,
//         "description": description,
//         "date": date,
//         "startTime": startTime,
//         "endTime": endTime,
//         "duration": duration,
//         "price": price,
//         "discount": discount,
//         "user": user.toJson(),
//     };
// }

// class EventUser {
//     String firstName;
//     String lastName;
//     String profilePicture;
//     String designation;
//     String company;

//     EventUser({
//         required this.firstName,
//         required this.lastName,
//         required this.profilePicture,
//         required this.designation,
//         required this.company,
//     });

//     factory EventUser.fromJson(Map<String, dynamic> json) => EventUser(
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         profilePicture: json["profilePicture"],
//         designation: json["designation"],
//         company: json["company"],
//     );

//     Map<String, dynamic> toJson() => {
//         "firstName": firstName,
//         "lastName": lastName,
//         "profilePicture": profilePicture,
//         "designation": designation,
//         "company": company,
//     };
// }

// class Post {
//     String id;
//     String category;
//     String description;
//     PostUser user;
//     String? image;
//     List<String> images;
//     List<String> likes;
//     String postType;
//     bool allowMultipleAnswers;
//     String communityId;
//     List<dynamic> comments;
//     List<PollOption> pollOptions;
//     DateTime createdAt;
//     DateTime updatedAt;
//     int v;

//     Post({
//         required this.id,
//         required this.category,
//         required this.description,
//         required this.user,
//         this.image,
//         required this.images,
//         required this.likes,
//         required this.postType,
//         required this.allowMultipleAnswers,
//         required this.communityId,
//         required this.comments,
//         required this.pollOptions,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.v,
//     });

//     factory Post.fromJson(Map<String, dynamic> json) => Post(
//         id: json["_id"],
//         category: json["category"],
//         description: json["description"],
//         user: PostUser.fromJson(json["user"]),
//         image: json["image"],
//         images: List<String>.from(json["images"].map((x) => x)),
//         likes: List<String>.from(json["likes"].map((x) => x)),
//         postType: json["postType"],
//         allowMultipleAnswers: json["allow_multiple_answers"],
//         communityId: json["communityId"],
//         comments: List<dynamic>.from(json["comments"].map((x) => x)),
//         pollOptions: List<PollOption>.from(json["pollOptions"].map((x) => PollOption.fromJson(x))),
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "category": category,
//         "description": description,
//         "user": user.toJson(),
//         "image": image,
//         "images": List<dynamic>.from(images.map((x) => x)),
//         "likes": List<dynamic>.from(likes.map((x) => x)),
//         "postType": postType,
//         "allow_multiple_answers": allowMultipleAnswers,
//         "communityId": communityId,
//         "comments": List<dynamic>.from(comments.map((x) => x)),
//         "pollOptions": List<dynamic>.from(pollOptions.map((x) => x.toJson())),
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//     };
// }

// class PollOption {
//     String option;
//     List<String> votes;
//     String id;

//     PollOption({
//         required this.option,
//         required this.votes,
//         required this.id,
//     });

//     factory PollOption.fromJson(Map<String, dynamic> json) => PollOption(
//         option: json["option"],
//         votes: List<String>.from(json["votes"].map((x) => x)),
//         id: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "option": option,
//         "votes": List<dynamic>.from(votes.map((x) => x)),
//         "_id": id,
//     };
// }

// class PostUser {
//     IsTopVoice isTopVoice;
//     String id;
//     String firstName;
//     String lastName;
//     String profilePicture;
//     bool isSubscribed;
//     String oneLinkId;
//     String userName;
//     StartUp startUp;
//     String designation;
//     String location;

//     PostUser({
//         required this.isTopVoice,
//         required this.id,
//         required this.firstName,
//         required this.lastName,
//         required this.profilePicture,
//         required this.isSubscribed,
//         required this.oneLinkId,
//         required this.userName,
//         required this.startUp,
//         required this.designation,
//         required this.location,
//     });

//     factory PostUser.fromJson(Map<String, dynamic> json) => PostUser(
//         isTopVoice: IsTopVoice.fromJson(json["isTopVoice"]),
//         id: json["_id"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         profilePicture: json["profilePicture"],
//         isSubscribed: json["isSubscribed"],
//         oneLinkId: json["oneLinkId"],
//         userName: json["userName"],
//         startUp: StartUp.fromJson(json["startUp"]),
//         designation: json["designation"],
//         location: json["location"],
//     );

//     Map<String, dynamic> toJson() => {
//         "isTopVoice": isTopVoice.toJson(),
//         "_id": id,
//         "firstName": firstName,
//         "lastName": lastName,
//         "profilePicture": profilePicture,
//         "isSubscribed": isSubscribed,
//         "oneLinkId": oneLinkId,
//         "userName": userName,
//         "startUp": startUp.toJson(),
//         "designation": designation,
//         "location": location,
//     };
// }

// class IsTopVoice {
//     bool status;

//     IsTopVoice({
//         required this.status,
//     });

//     factory IsTopVoice.fromJson(Map<String, dynamic> json) => IsTopVoice(
//         status: json["status"],
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//     };
// }

// class StartUp {
//     String id;
//     String company;

//     StartUp({
//         required this.id,
//         required this.company,
//     });

//     factory StartUp.fromJson(Map<String, dynamic> json) => StartUp(
//         id: json["_id"],
//         company: json["company"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "company": company,
//     };
// }

// class Product {
//     String name;
//     String image;
//     String description;
//     bool isFree;
//     int amount;
//     List<String> urls;

//     Product({
//         required this.name,
//         required this.image,
//         required this.description,
//         required this.isFree,
//         required this.amount,
//         required this.urls,
//     });

//     factory Product.fromJson(Map<String, dynamic> json) => Product(
//         name: json["name"],
//         image: json["image"],
//         description: json["description"],
//         isFree: json["is_free"],
//         amount: json["amount"],
//         urls: List<String>.from(json["URLS"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "name": name,
//         "image": image,
//         "description": description,
//         "is_free": isFree,
//         "amount": amount,
//         "URLS": List<dynamic>.from(urls.map((x) => x)),
//     };
// }

// To parse this JSON data, do
//
//     final getAboutCommunityModel = getAboutCommunityModelFromJson(jsonString);

import 'dart:convert';

GetAboutCommunityModel getAboutCommunityModelFromJson(String str) =>
    GetAboutCommunityModel.fromJson(json.decode(str));

String getAboutCommunityModelToJson(GetAboutCommunityModel data) =>
    json.encode(data.toJson());

class GetAboutCommunityModel {
  bool status;
  String message;
  AboutCommunity? data;

  GetAboutCommunityModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory GetAboutCommunityModel.fromJson(Map<String, dynamic> json) =>
      GetAboutCommunityModel(
        status: json["status"],
        message: json["message"],
        data: AboutCommunity.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class AboutCommunity {
  Community? community;
  Admin? admin;
  List<Product>? products;
  List<Post>? posts;
  List<Event>? events;

  AboutCommunity({
    this.community,
    this.admin,
    this.products,
    this.posts,
    this.events,
  });

  factory AboutCommunity.fromJson(Map<String, dynamic> json) => AboutCommunity(
        community: Community.fromJson(json["community"]),
        admin: Admin.fromJson(json["admin"]),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
        events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "community": community!.toJson(),
        "admin": admin!.toJson(),
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
        "posts": List<dynamic>.from(posts!.map((x) => x.toJson())),
        "events": List<dynamic>.from(events!.map((x) => x.toJson())),
      };
}

class Admin {
  String? firstName;
  String? lastName;
  String? profilePicture;
  String? designation;
  String? bio;
  String? company;
  String? location;

  Admin({
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.designation,
    this.bio,
    this.company,
    this.location,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePicture: json["profilePicture"],
        designation: json["designation"],
        bio: json["bio"],
        company: json["company"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture,
        "designation": designation,
        "bio": bio,
        "company": company,
        "location": location,
      };
}

class Community {
  String? name;
  String? image;
  String? banner;
  String? about;
  List<String>? termsAndConditions;
  String? whatsappGroupLink;
  bool? isOpen;
  int? amount;
  String? communitySize;
  String? subscription;
  String? shareLink;

  Community({
    this.name,
    this.image,
    this.banner,
    this.about,
    this.termsAndConditions,
    this.whatsappGroupLink,
    this.isOpen,
    this.amount,
    this.communitySize,
    this.subscription,
    this.shareLink,
  });

  factory Community.fromJson(Map<String, dynamic> json) => Community(
        name: json["name"],
        banner: json["banner"],
        image: json["image"],
        about: json["about"],
        termsAndConditions:
            List<String>.from(json["terms_and_conditions"].map((x) => x)),
        whatsappGroupLink: json["whatsapp_group_link"],
        isOpen: json["isOpen"],
        amount: json["amount"],
        communitySize: json["communitySize"],
        subscription: json["subscription"],
        shareLink: json["shareLink"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "about": about,
        "terms_and_conditions":
            List<dynamic>.from(termsAndConditions!.map((x) => x)),
        "whatsapp_group_link": whatsappGroupLink,
        "isOpen": isOpen,
        "amount": amount,
        "communitySize": communitySize,
        "subscription": subscription,
        "shareLink": shareLink,
      };
}

class Event {
  String? id;
  String? title;
  String? description;
  String? date;
  String? startTime;
  String? endTime;
  int? duration;
  int? price;
  int? discount;
  EventUser? user;

  Event({
    this.id,
    this.title,
    this.description,
    this.date,
    this.startTime,
    this.endTime,
    this.duration,
    this.price,
    this.discount,
    this.user,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        duration: json["duration"],
        price: json["price"],
        discount: json["discount"],
        user: EventUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "duration": duration,
        "price": price,
        "discount": discount,
        "user": user!.toJson(),
      };
}

class EventUser {
  String? firstName;
  String? lastName;
  String? profilePicture;
  String? designation;
  String? company;

  EventUser({
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.designation,
    this.company,
  });

  factory EventUser.fromJson(Map<String, dynamic> json) => EventUser(
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePicture: json["profilePicture"],
        designation: json["designation"],
        company: json["company"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture,
        "designation": designation,
        "company": company,
      };
}

class Post {
  String? id;
  String? postType;
  String? title;
  String? description;
  String? image;
  String? communityId;
  PostUser? user;
  String? resharedPostId;
  List<dynamic>? comments;
  List<String>? likes;
  int? views;
  int? reshares;
  String? createdAt;

  Post({
    this.id,
    this.postType,
    this.title,
    this.description,
    this.image,
    this.communityId,
    this.user,
    this.resharedPostId,
    this.comments,
    this.likes,
    this.views,
    this.reshares,
    this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        postType: json["postType"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        communityId: json["communityId"],
        user: PostUser.fromJson(json["user"]),
        resharedPostId: json["resharedPostId"],
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        likes: List<String>.from(json["likes"].map((x) => x)),
        views: json["views"],
        reshares: json["reshares"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "postType": postType,
        "title": title,
        "description": description,
        "image": image,
        "communityId": communityId,
        "user": user!.toJson(),
        "resharedPostId": resharedPostId,
        "comments": List<dynamic>.from(comments!.map((x) => x)),
        "likes": List<dynamic>.from(likes!.map((x) => x)),
        "views": views,
        "reshares": reshares,
        "createdAt": createdAt,
      };
}

class PostUser {
  IsTopVoice? isTopVoice;
  String? id;
  String? firstName;
  String? lastName;
  String? profilePicture;
  bool? isSubscribed;
  String? oneLinkId;
  String? userName;
  // StartUp? startUp;
  String? designation;
  String? location;

  PostUser({
    this.isTopVoice,
    this.id,
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.isSubscribed,
    this.oneLinkId,
    this.userName,
    // this.startUp,
    this.designation,
    this.location,
  });

  factory PostUser.fromJson(Map<String, dynamic> json) => PostUser(
        isTopVoice: IsTopVoice.fromJson(json["isTopVoice"]),
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePicture: json["profilePicture"],
        isSubscribed: json["isSubscribed"],
        oneLinkId: json["oneLinkId"],
        userName: json["userName"],
        // startUp: StartUp.fromJson(json["startUp"]),
        designation: json["designation"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "isTopVoice": isTopVoice!.toJson(),
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture,
        "isSubscribed": isSubscribed,
        "oneLinkId": oneLinkId,
        "userName": userName,
        // "startUp": startUp!.toJson(),
        "designation": designation,
        "location": location,
      };
}

class IsTopVoice {
  bool? status;

  IsTopVoice({
    this.status,
  });

  factory IsTopVoice.fromJson(Map<String, dynamic> json) => IsTopVoice(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}

// class StartUp {
//   String? id;
//   String? company;

//   StartUp({
//     this.id,
//     this.company,
//   });

//   factory StartUp.fromJson(Map<String, dynamic> json) => StartUp(
//         id: json["_id"],
//         company: json["company"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "company": company,
//       };
// }

class Product {
  String? name;
  String? image;
  String? description;
  bool? isFree;
  int? amount;
  List<String>? urls;

  Product({
    this.name,
    this.image,
    this.description,
    this.isFree,
    this.amount,
    this.urls,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        image: json["image"],
        description: json["description"],
        isFree: json["is_free"],
        amount: json["amount"],
        urls: List<String>.from(json["URLS"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "description": description,
        "is_free": isFree,
        "amount": amount,
        "URLS": List<dynamic>.from(urls!.map((x) => x)),
      };
}
