// To parse this JSON data, do
//
//     final getWebinarsModel = getWebinarsModelFromJson(jsonString);

import 'dart:convert';

GetWebinarsModel getWebinarsModelFromJson(String str) =>
    GetWebinarsModel.fromJson(json.decode(str));

String getWebinarsModelToJson(GetWebinarsModel data) =>
    json.encode(data.toJson());

class GetWebinarsModel {
  bool status;
  String message;
  List<Webinar> data;

  GetWebinarsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetWebinarsModel.fromJson(Map<String, dynamic> json) =>
      GetWebinarsModel(
        status: json["status"],
        message: json["message"],
        data: List<Webinar>.from(json["data"].map((x) => Webinar.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
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
        joinedUsers: List<JoinedUser>.from(
            json["joinedUsers"].map((x) => JoinedUser.fromJson(x))),
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
      };
}

class JoinedUser {
  String name;
  String email;
  String mobile;
  String? orderId;
  String? paymentId;
  String paymentStatus;
  DateTime paymentTime;
  int paymentAmount;
  String id;

  JoinedUser({
    required this.name,
    required this.email,
    required this.mobile,
    this.orderId,
    this.paymentId,
    required this.paymentStatus,
    required this.paymentTime,
    required this.paymentAmount,
    required this.id,
  });

  factory JoinedUser.fromJson(Map<String, dynamic> json) => JoinedUser(
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        orderId: json["orderId"] ?? "",
        paymentId: json["paymentId"] ?? "",
        paymentStatus: json["paymentStatus"],
        paymentTime: DateTime.parse(json["paymentTime"]),
        paymentAmount: json["paymentAmount"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "mobile": mobile,
        "orderId": orderId,
        "paymentId": paymentId,
        "paymentStatus": paymentStatus,
        "paymentTime": paymentTime.toIso8601String(),
        "paymentAmount": paymentAmount,
        "_id": id,
      };
}
