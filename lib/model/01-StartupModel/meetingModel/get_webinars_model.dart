// To parse this JSON data, do
//
//     final getWebinarsModel = getWebinarsModelFromJson(jsonString);

import 'dart:convert';

GetWebinarsModel getWebinarsModelFromJson(String str) => GetWebinarsModel.fromJson(json.decode(str));

String getWebinarsModelToJson(GetWebinarsModel data) => json.encode(data.toJson());

class GetWebinarsModel {
    bool status;
    String message;
    List<Webinar> data;

    GetWebinarsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetWebinarsModel.fromJson(Map<String, dynamic> json) => GetWebinarsModel(
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
    String date;
    String title;
    String description;
    String startTime;
    String endTime;
    String duration;
    String discount;
    String price;
    String link;
    String creatorName;

    Webinar({
        required this.id,
        required this.date,
        required this.title,
        required this.description,
        required this.startTime,
        required this.endTime,
        required this.duration,
        required this.discount,
        required this.price,
        required this.link,
        required this.creatorName,
    });

    factory Webinar.fromJson(Map<String, dynamic> json) => Webinar(
        id: json["_id"],
        date: json["date"],
        title: json["title"],
        description: json["description"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        duration: json["duration"],
        discount: json["discount"],
        price: json["price"],
        link: json["link"],
        creatorName: json["creatorName"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "date": date,
        "title": title,
        "description": description,
        "startTime": startTime,
        "endTime": endTime,
        "duration": duration,
        "discount": discount,
        "price": price,
        "link": link,
        "creatorName": creatorName,
    };
}
