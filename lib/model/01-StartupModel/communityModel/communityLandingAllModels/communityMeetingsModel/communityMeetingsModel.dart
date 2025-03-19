import 'dart:convert';

GetCommunityMeetingsModel getCommunityMeetingsModelFromJson(String str) =>
    GetCommunityMeetingsModel.fromJson(json.decode(str));

String getCommunityMeetingsModelToJson(GetCommunityMeetingsModel data) =>
    json.encode(data.toJson());

class GetCommunityMeetingsModel {
  bool? status;
  String? message;
  List<CommunityMeetings>? data;

  GetCommunityMeetingsModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetCommunityMeetingsModel.fromJson(Map<String, dynamic> json) =>
      GetCommunityMeetingsModel(
        status: json["status"] ?? null,
        message: json["message"] ?? null,
        data: json["data"] != null
            ? List<CommunityMeetings>.from(
                json["data"].map((x) => CommunityMeetings.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CommunityMeetings {
  String? id;
  String? title;
  String? description;
  int? amount;
  int? duration;
  List<String>? topics;
  List<Availability>? availability;
  List<Booking>? bookings;

  CommunityMeetings({
    this.id,
    this.title,
    this.description,
    this.amount,
    this.duration,
    this.topics,
    this.availability,
    this.bookings,
  });

  factory CommunityMeetings.fromJson(Map<String, dynamic> json) =>
      CommunityMeetings(
        id: json["_id"] ?? null,
        title: json["title"] ?? null,
        description: json["description"] ?? null,
        amount: json["amount"] ?? null,
        duration: json["duration"] ?? null,
        topics: json["topics"] != null
            ? List<String>.from(json["topics"].map((x) => x))
            : null,
        availability: json["availability"] != null
            ? List<Availability>.from(
                json["availability"].map((x) => Availability.fromJson(x)))
            : null,
        bookings: json["bookings"] != null
            ? List<Booking>.from(
                json["bookings"]!.map((x) => Booking.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "amount": amount,
        "duration": duration,
        "topics":
            topics == null ? [] : List<dynamic>.from(topics!.map((x) => x)),
        "availability": availability == null
            ? []
            : List<dynamic>.from(availability!.map((x) => x.toJson())),
        "bookings": bookings == null
            ? []
            : List<dynamic>.from(bookings!.map((x) => x.toJson())),
      };
}

class Availability {
  String? id;
  String? day;
  List<SlotElement>? slots;

  Availability({
    this.id,
    this.day,
    this.slots,
  });

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        id: json["_id"] ?? null,
        day: json["day"] ?? null,
        slots: json["slots"] != null
            ? List<SlotElement>.from(
                json["slots"].map((x) => SlotElement.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "day": day,
        "slots": slots == null
            ? []
            : List<dynamic>.from(slots!.map((x) => x.toJson())),
      };
}

class SlotElement {
  String? id;
  String? startTime;
  String? endTime;
  bool? isBooked;
  String? meetingLink;
  String? memberEmail;

  SlotElement({
    this.id,
    this.startTime,
    this.endTime,
    this.isBooked,
    this.meetingLink,
    this.memberEmail,
  });

  factory SlotElement.fromJson(Map<String, dynamic> json) => SlotElement(
        id: json["_id"] ?? null,
        startTime: json["startTime"] ?? null,
        endTime: json["endTime"] ?? null,
        isBooked: json["isBooked"] ?? null,
        meetingLink: json["meeting_link"] ?? null,
        memberEmail: json["memberEmail"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "startTime": startTime,
        "endTime": endTime,
        "isBooked": isBooked,
        "meeting_link": meetingLink,
        "memberEmail": memberEmail,
      };
}

class Booking {
  String? id;
  UserId? userId;
  BookingSlot? slot;
  Payment? payment;
  String? createdAt;

  Booking({
    this.id,
    this.userId,
    this.slot,
    this.payment,
    this.createdAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["_id"] ?? null,
        userId: json["userId"] != null ? UserId.fromJson(json["userId"]) : null,
        slot: json["slot"] != null ? BookingSlot.fromJson(json["slot"]) : null,
        payment:
            json["payment"] != null ? Payment.fromJson(json["payment"]) : null,
        createdAt: json["createdAt"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId?.toJson(),
        "slot": slot?.toJson(),
        "payment": payment?.toJson(),
        "createdAt": createdAt,
      };
}

class Payment {
  String? paymentId;
  String? orderId;
  String? status;
  int? amount;
  dynamic paymentTime;

  Payment({
    this.paymentId,
    this.orderId,
    this.status,
    this.amount,
    this.paymentTime,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        paymentId: json["paymentId"] ?? null,
        orderId: json["orderId"] ?? null,
        status: json["status"] ?? null,
        amount: json["amount"] ?? null,
        paymentTime: json["paymentTime"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "paymentId": paymentId,
        "orderId": orderId,
        "status": status,
        "amount": amount,
        "paymentTime": paymentTime,
      };
}

class BookingSlot {
  String? day;
  String? startTime;
  String? endTime;
  String? meetingLink;

  BookingSlot({
    this.day,
    this.startTime,
    this.endTime,
    this.meetingLink,
  });

  factory BookingSlot.fromJson(Map<String, dynamic> json) => BookingSlot(
        day: json["day"] ?? null,
        startTime: json["startTime"] ?? null,
        endTime: json["endTime"] ?? null,
        meetingLink: json["meeting_link"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "startTime": startTime,
        "endTime": endTime,
        "meeting_link": meetingLink,
      };
}

class UserId {
  String? id;
  String? firstName;
  String? lastName;
  String? profilePicture;

  UserId({
    this.id,
    this.firstName,
    this.lastName,
    this.profilePicture,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"] ?? null,
        firstName: json["firstName"] ?? null,
        lastName: json["lastName"] ?? null,
        profilePicture: json["profilePicture"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture,
      };
}
