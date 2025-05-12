// To parse this JSON data, do
//
//     final getEventsModel = getEventsModelFromJson(jsonString);

import 'dart:convert';

GetEventsModel getEventsModelFromJson(String str) => GetEventsModel.fromJson(json.decode(str));

String getEventsModelToJson(GetEventsModel data) => json.encode(data.toJson());

class GetEventsModel {
    bool status;
    String message;
    List<Datum> data;

    GetEventsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetEventsModel.fromJson(Map<String, dynamic> json) => GetEventsModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String id;
    bool isActive;
    String title;
    String duration;
    String price;
    String discount;
    String url;
    List<Booking> bookings;
    String eventType;

    Datum({
        required this.id,
        required this.isActive,
        required this.title,
        required this.duration,
        required this.price,
        required this.discount,
        required this.url,
        required this.bookings,
        required this.eventType,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        isActive: json["isActive"],
        title: json["title"],
        duration: json["duration"],
        price: json["price"],
        discount: json["discount"],
        url: json["url"],
        bookings: List<Booking>.from(json["bookings"].map((x) => Booking.fromJson(x))),
        eventType: json["eventType"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "isActive": isActive,
        "title": title,
        "duration": duration,
        "price": price,
        "discount": discount,
        "url": url,
        "bookings": List<dynamic>.from(bookings.map((x) => x.toJson())),
        "eventType": eventType,
    };
}

class Booking {
    String id;
    String name;
    String email;

    Booking({
        required this.id,
        required this.name,
        required this.email,
    });

    factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
    };
}
