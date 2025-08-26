// // To parse this JSON data, do
// //
// //     final getCreatedCommunityModel = getCreatedCommunityModelFromJson(jsonString);

// import 'dart:convert';

// GetCreatedCommunityModel getCreatedCommunityModelFromJson(String str) => GetCreatedCommunityModel.fromJson(json.decode(str));

// String getCreatedCommunityModelToJson(GetCreatedCommunityModel data) => json.encode(data.toJson());

// class GetCreatedCommunityModel {
//     CreatedCommunity data;

//     GetCreatedCommunityModel({
//         required this.data,
//     });

//     factory GetCreatedCommunityModel.fromJson(Map<String, dynamic> json) => GetCreatedCommunityModel(
//         data: CreatedCommunity.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "data": data.toJson(),
//     };
// }

// class CreatedCommunity {
//     String? image;
//     String name;
//     String? subscription;
//     dynamic amount;
//     String? shareLink;
//     // String whatsappGroupLink;

//     CreatedCommunity({
//         this.image,
//         required this.name,
//         this.subscription,
//         required this.amount,
//         this.shareLink
//         // required this.whatsappGroupLink,
//     });

//     factory CreatedCommunity.fromJson(Map<String, dynamic> json) => CreatedCommunity(
//         image: json["image"],
//         name: json["name"],
//         subscription: json["subscription"],
//         amount: json["amount"],
//         shareLink: json["shareLink"]
//         // whatsappGroupLink: json["whatsapp_group_link"]
//     );

//     Map<String, dynamic> toJson() => {
//         "image": image,
//         "name": name,
//         "subscription": subscription,
//         "amount": amount,
//         "shareLink":shareLink
//         // "whatsapp_group_link" : whatsappGroupLink
//     };
// }

// To parse this JSON data, do
//
//     final getCreatedCommunityModel = getCreatedCommunityModelFromJson(jsonString);

import 'dart:convert';

GetCreatedCommunityModel getCreatedCommunityModelFromJson(String str) => GetCreatedCommunityModel.fromJson(json.decode(str));

String getCreatedCommunityModelToJson(GetCreatedCommunityModel data) => json.encode(data.toJson());

class GetCreatedCommunityModel {
    bool status;
    String message;
    CreatedCommunity data;

    GetCreatedCommunityModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetCreatedCommunityModel.fromJson(Map<String, dynamic> json) => GetCreatedCommunityModel(
        status: json["status"],
        message: json["message"],
        data: CreatedCommunity.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class CreatedCommunity {
    Community community;
    Admin admin;
    List<Product> products;
    List<dynamic> posts;
    List<Event> events;

    CreatedCommunity({
        required this.community,
        required this.admin,
        required this.products,
        required this.posts,
        required this.events,
    });

    factory CreatedCommunity.fromJson(Map<String, dynamic> json) => CreatedCommunity(
        community: Community.fromJson(json["community"]),
        admin: Admin.fromJson(json["admin"]),
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
        posts: List<dynamic>.from(json["posts"].map((x) => x)),
        events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "community": community.toJson(),
        "admin": admin.toJson(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "posts": List<dynamic>.from(posts.map((x) => x)),
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
    };
}

class Admin {
    String firstName;
    String lastName;
    String profilePicture;
    String designation;
    String bio;
    String company;
    String location;

    Admin({
        required this.firstName,
        required this.lastName,
        required this.profilePicture,
        required this.designation,
        required this.bio,
        required this.company,
        required this.location,
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
    String name;
    String image;
    String about;
    List<String> termsAndConditions;
    String whatsappGroupLink;
    bool isOpen;
    String shareLink;

    Community({
        required this.name,
        required this.image,
        required this.about,
        required this.termsAndConditions,
        required this.whatsappGroupLink,
        required this.isOpen,
        required this.shareLink,
    });

    factory Community.fromJson(Map<String, dynamic> json) => Community(
        name: json["name"],
        image: json["image"],
        about: json["about"],
        termsAndConditions: List<String>.from(json["terms_and_conditions"].map((x) => x)),
        whatsappGroupLink: json["whatsapp_group_link"],
        isOpen: json["isOpen"],
        shareLink: json["shareLink"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "about": about,
        "terms_and_conditions": List<dynamic>.from(termsAndConditions.map((x) => x)),
        "whatsapp_group_link": whatsappGroupLink,
        "isOpen": isOpen,
        "shareLink": shareLink,
    };
}

class Event {
    String id;
    String title;
    String description;
    String date;
    String startTime;
    String endTime;
    int duration;
    int price;
    String discount;
    User user;

    Event({
        required this.id,
        required this.title,
        required this.description,
        required this.date,
        required this.startTime,
        required this.endTime,
        required this.duration,
        required this.price,
        required this.discount,
        required this.user,
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
        user: User.fromJson(json["user"]),
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
        "user": user.toJson(),
    };
}

class User {
    String firstName;
    String lastName;
    String profilePicture;
    String designation;
    String company;

    User({
        required this.firstName,
        required this.lastName,
        required this.profilePicture,
        required this.designation,
        required this.company,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
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

class Product {
    String name;
    String image;
    String description;
    bool isFree;
    int amount;
    List<String> urls;

    Product({
        required this.name,
        required this.image,
        required this.description,
        required this.isFree,
        required this.amount,
        required this.urls,
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
        "URLS": List<dynamic>.from(urls.map((x) => x)),
    };
}
