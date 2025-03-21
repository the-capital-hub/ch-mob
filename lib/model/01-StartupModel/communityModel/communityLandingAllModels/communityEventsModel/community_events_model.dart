// To parse this JSON data, do
//
//     final getCommunityEventsModel = getCommunityEventsModelFromJson(jsonString);

import 'dart:convert';

GetCommunityEventsModel getCommunityEventsModelFromJson(String str) => GetCommunityEventsModel.fromJson(json.decode(str));

String getCommunityEventsModelToJson(GetCommunityEventsModel data) => json.encode(data.toJson());

class GetCommunityEventsModel {
    bool status;
    String message;
    CommunityEvent data;

    GetCommunityEventsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetCommunityEventsModel.fromJson(Map<String, dynamic> json) => GetCommunityEventsModel(
        status: json["status"],
        message: json["message"],
        data: CommunityEvent.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class CommunityEvent {
    List<Webinar>? webinars;

    CommunityEvent({
        this.webinars,
    });

    factory CommunityEvent.fromJson(Map<String, dynamic> json) => CommunityEvent(
        webinars: List<Webinar>.from(json["webinars"].map((x) => Webinar.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "webinars": List<dynamic>.from(webinars!.map((x) => x.toJson())),
    };
}

class Webinar {
    String id;
    bool isActive;
    String date;
    String title;
    String description;
    String startTime;
    String endTime;
    String duration;
    String discount;
    String price;
    String webinarLink;
    String creatorName;
    List<JoinedUser> joinedUsers;
    String registerUrl;

    Webinar({
        required this.id,
        required this.isActive,
        required this.date,
        required this.title,
        required this.description,
        required this.startTime,
        required this.endTime,
        required this.duration,
        required this.discount,
        required this.price,
        required this.webinarLink,
        required this.creatorName,
        required this.joinedUsers,
        required this.registerUrl,
    });

    factory Webinar.fromJson(Map<String, dynamic> json) => Webinar(
        id: json["_id"],
        isActive: json["isActive"],
        date: json["date"],
        title: json["title"],
        description: json["description"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        duration: json["duration"],
        discount: json["discount"],
        price: json["price"],
        webinarLink: json["webinarLink"],
        creatorName: json["creatorName"],
        joinedUsers: List<JoinedUser>.from(json["joinedUsers"].map((x) => JoinedUser.fromJson(x))),
        registerUrl: json["registerUrl"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "isActive": isActive,
        "date": date,
        "title": title,
        "description": description,
        "startTime": startTime,
        "endTime": endTime,
        "duration": duration,
        "discount": discount,
        "price": price,
        "webinarLink": webinarLink,
        "creatorName": creatorName,
        "joinedUsers": List<dynamic>.from(joinedUsers.map((x) => x.toJson())),
        "registerUrl": registerUrl,
    };
}

class JoinedUser {
    String name;
    String email;
    String mobile;
    dynamic orderId;
    dynamic paymentId;
    dynamic paymentTime;
    int paymentAmount;
    String id;

    JoinedUser({
        required this.name,
        required this.email,
        required this.mobile,
        required this.orderId,
        required this.paymentId,
        required this.paymentTime,
        required this.paymentAmount,
        required this.id,
    });

    factory JoinedUser.fromJson(Map<String, dynamic> json) => JoinedUser(
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        orderId: json["orderId"],
        paymentId: json["paymentId"],
        paymentTime: json["paymentTime"],
        paymentAmount: json["paymentAmount"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "mobile": mobile,
        "orderId": orderId,
        "paymentId": paymentId,
        "paymentTime": paymentTime,
        "paymentAmount": paymentAmount,
        "_id": id,
    };
}
