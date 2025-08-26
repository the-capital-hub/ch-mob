// To parse this JSON data, do
//
//     final getCommunityEventsModel = getCommunityEventsModelFromJson(jsonString);

import 'dart:convert';

GetCommunityWebinarModel getCommunityEventsModelFromJson(String str) =>
    GetCommunityWebinarModel.fromJson(json.decode(str));

String getCommunityEventsModelToJson(GetCommunityWebinarModel data) =>
    json.encode(data.toJson());

class GetCommunityWebinarModel {
  bool status;
  String message;
  CommunityEvent data;

  GetCommunityWebinarModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetCommunityWebinarModel.fromJson(Map<String, dynamic> json) =>
      GetCommunityWebinarModel(
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
  List<CommnunityWebinar>? webinars;

  CommunityEvent({
    this.webinars,
  });

  factory CommunityEvent.fromJson(Map<String, dynamic> json) => CommunityEvent(
        webinars: List<CommnunityWebinar>.from(
            json["webinars"].map((x) => CommnunityWebinar.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "webinars": List<dynamic>.from(webinars!.map((x) => x.toJson())),
      };
}

class CommnunityWebinar {
  String? id;
  bool? isActive;
  bool? isExpired;
  String? date;
  String? title;
  String? description;
  String? startTime;
  String? endTime;
  String? duration;
  String? discount;
  String? price;
  String? image;
  String? webinarLink;
  String? creatorName;
  List<JoinedUser>? joinedUsers;
  String? registerUrl;
  String? webinarSharelink;

  CommnunityWebinar({
    this.id,
    this.isActive,
    this.isExpired,
    this.date,
    this.title,
    this.description,
    this.startTime,
    this.endTime,
    this.duration,
    this.discount,
    this.price,
    this.webinarLink,
    this.creatorName,
    this.joinedUsers,
    this.registerUrl,
    this.image,
    this.webinarSharelink,
  });

  factory CommnunityWebinar.fromJson(Map<String, dynamic> json) =>
      CommnunityWebinar(
          id: json["_id"],
          isActive: json["isActive"],
          isExpired: json["is_expired"],
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
          joinedUsers: List<JoinedUser>.from(
              json["joinedUsers"].map((x) => JoinedUser.fromJson(x))),
          registerUrl: json["registerUrl"],
          image: json["image"],
          webinarSharelink: json["webinar_shareLink"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "isActive": isActive,
        "is_expired": isExpired,
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
        "joinedUsers": List<dynamic>.from(joinedUsers!.map((x) => x.toJson())),
        "registerUrl": registerUrl,
        "image": image,
        "webinar_shareLink": webinarSharelink
      };
}

class JoinedUser {
  String? name;
  String? email;
  String? mobile;
  String? orderId;
  String? paymentId;
  String? paymentTime;
  int? paymentAmount;
  String? id;

  JoinedUser({
    this.name,
    this.email,
    this.mobile,
    this.orderId,
    this.paymentId,
    this.paymentTime,
    this.paymentAmount,
    this.id,
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
