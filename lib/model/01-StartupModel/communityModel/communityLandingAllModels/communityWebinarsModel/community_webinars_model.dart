import 'dart:convert';

GetCommunityWebinarsModel getCommunityWebinarsModelFromJson(String str) =>
    GetCommunityWebinarsModel.fromJson(json.decode(str));

String getCommunityWebinarsModelToJson(GetCommunityWebinarsModel data) =>
    json.encode(data.toJson());

class GetCommunityWebinarsModel {
  bool? status;
  String? message;
  List<CommunityWebinars>? data;

  GetCommunityWebinarsModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetCommunityWebinarsModel.fromJson(Map<String, dynamic> json) =>
      GetCommunityWebinarsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<CommunityWebinars>.from(json["data"].map((x) => CommunityWebinars.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CommunityWebinars {
  bool? isAdmin;
  String? id;
  String? eventId;
  String? title;
  String? description;
  String? date;
  int? price;
  int? discount;
  int? duration;
  List<Booking>? bookings;
  int? joined;

  CommunityWebinars({
    this.isAdmin,
    this.id,
    this.eventId,
    this.title,
    this.description,
    this.date,
    this.price,
    this.discount,
    this.duration,
    this.bookings,
    this.joined,
  });

  factory CommunityWebinars.fromJson(Map<String, dynamic> json) => CommunityWebinars(
        isAdmin: json["isAdmin"],
        id: json["_id"],
        eventId: json["eventId"],
        title: json["title"],
        description: json["description"],
        date: json["date"],
        price: json["price"],
        discount: json["discount"],
        duration: json["duration"],
        bookings: json["bookings"] == null
            ? null
            : List<Booking>.from(json["bookings"].map((x) => Booking.fromJson(x))),
        joined: json["joined"],
      );

  Map<String, dynamic> toJson() => {
        "isAdmin": isAdmin,
        "_id": id,
        "eventId": eventId,
        "title": title,
        "description": description,
        "date": date,
        "price": price,
        "discount": discount,
        "duration": duration,
        "bookings": bookings == null
            ? null
            : List<dynamic>.from(bookings!.map((x) => x.toJson())),
        "joined": joined,
      };
}

class Booking {
  String? id;
  String? name;
  String? email;
  String? additionalInfo;
  String? startTime;
  String? endTime;
  String? meetingLink;
  String? bookedAt;

  Booking({
    this.id,
    this.name,
    this.email,
    this.additionalInfo,
    this.startTime,
    this.endTime,
    this.meetingLink,
    this.bookedAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        additionalInfo: json["additionalInfo"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        meetingLink: json["meeting_link"],
        bookedAt: json["bookedAt"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "additionalInfo": additionalInfo,
        "startTime": startTime,
        "endTime": endTime,
        "meeting_link": meetingLink,
        "bookedAt": bookedAt,
      };
}
