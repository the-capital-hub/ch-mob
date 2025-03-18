// To parse this JSON data, do
//
//     final getCommunityWebinarsModel = getCommunityWebinarsModelFromJson(jsonString);

import 'dart:convert';

GetCommunityWebinarsModel getCommunityWebinarsModelFromJson(String str) => GetCommunityWebinarsModel.fromJson(json.decode(str));

String getCommunityWebinarsModelToJson(GetCommunityWebinarsModel data) => json.encode(data.toJson());

class GetCommunityWebinarsModel {
    bool status;
    String message;
    List<CommunityWebinars> data;

    GetCommunityWebinarsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetCommunityWebinarsModel.fromJson(Map<String, dynamic> json) => GetCommunityWebinarsModel(
        status: json["status"],
        message: json["message"],
        data: List<CommunityWebinars>.from(json["data"].map((x) => CommunityWebinars.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class CommunityWebinars {
    String id;
    String eventId;
    String title;
    String description;
    String date;
    int price;
    int discount;
    int duration;
    List<Booking> bookings;

    CommunityWebinars({
        required this.id,
        required this.eventId,
        required this.title,
        required this.description,
        required this.date,
        required this.price,
        required this.discount,
        required this.duration,
        required this.bookings,
    });

    factory CommunityWebinars.fromJson(Map<String, dynamic> json) => CommunityWebinars(
        id: json["_id"],
        eventId: json["eventId"],
        title: json["title"],
        description: json["description"],
        date: json["date"],
        price: json["price"],
        discount: json["discount"],
        duration: json["duration"],
        bookings: List<Booking>.from(json["bookings"].map((x) => Booking.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "eventId": eventId,
        "title": title,
        "description": description,
        "date": date,
        "price": price,
        "discount": discount,
        "duration": duration,
        "bookings": List<dynamic>.from(bookings.map((x) => x.toJson())),
    };
}

class Booking {
    String id;
    String name;
    String email;
    String additionalInfo;
    String startTime;
    String endTime;
    String meetingLink;

    Booking({
        required this.id,
        required this.name,
        required this.email,
        required this.additionalInfo,
        required this.startTime,
        required this.endTime,
        required this.meetingLink,
    });

    factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        additionalInfo: json["additionalInfo"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        meetingLink: json["meeting_link"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "additionalInfo": additionalInfo,
        "startTime": startTime,
        "endTime": endTime,
        "meeting_link": meetingLink,
    };
}
