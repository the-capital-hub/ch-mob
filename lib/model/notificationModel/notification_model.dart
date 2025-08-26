
import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  bool? status;
  String? message;
  List<NotificationData>? data;

  NotificationModel({
    this.status,
    this.message,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        status: json["status"],
        message: json["message"],
        data: List<NotificationData>.from(json["data"].map((x) => NotificationData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NotificationData {
  String? id;
  String? image;
  String? title;
  String? subTitle;
  String? date;
  bool? isRead;

  NotificationData({
    this.id,this.image,
    this.title,
    this.subTitle,
    this.date,
    this.isRead,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
        image: json["image"],
        id: json["id"],
        title: json["title"],
        subTitle: json["sub_title"],
        date: json["date"],
        isRead: json["is_read"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "sub_title": subTitle,
        "date": date,
        "is_read": isRead,
      };
}
