// To parse this JSON data, do
//
//     final getEventsModel = getEventsModelFromJson(jsonString);

import 'dart:convert';

GetEventsModel getEventsModelFromJson(String str) => GetEventsModel.fromJson(json.decode(str));

String getEventsModelToJson(GetEventsModel data) => json.encode(data.toJson());

class GetEventsModel {
    bool status;
    String message;
    List<Event> data;

    GetEventsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetEventsModel.fromJson(Map<String, dynamic> json) => GetEventsModel(
        status: json["status"],
        message: json["message"],
        data: List<Event>.from(json["data"].map((x) => Event.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Event {
    String id;
    String title;
    String duration;
    String price;
    String discount;
    String url;

    Event({
        required this.id,
        required this.title,
        required this.duration,
        required this.price,
        required this.discount,
        required this.url,
    });

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["_id"],
        title: json["title"],
        duration: json["duration"],
        price: json["price"],
        discount: json["discount"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "duration": duration,
        "price": price,
        "discount": discount,
        "url": url,
    };
}
