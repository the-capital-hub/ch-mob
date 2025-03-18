import 'dart:convert';

GetCommunityMeetingsModel getCommunityMeetingsModelFromJson(String str) => GetCommunityMeetingsModel.fromJson(json.decode(str));

String getCommunityMeetingsModelToJson(GetCommunityMeetingsModel data) => json.encode(data.toJson());

class GetCommunityMeetingsModel {
  bool? status;
  String? message;
  List<CommunityMeetings>? data;

  GetCommunityMeetingsModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetCommunityMeetingsModel.fromJson(Map<String, dynamic> json) => GetCommunityMeetingsModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] != null ? List<CommunityMeetings>.from(json["data"]?.map((x) => CommunityMeetings.fromJson(x))) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : null,
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

  factory CommunityMeetings.fromJson(Map<String, dynamic> json) => CommunityMeetings(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    amount: json["amount"],
    duration: json["duration"],
    topics: json["topics"] != null ? List<String>.from(json["topics"]?.map((x) => x)) : null,
    availability: json["availability"] != null ? List<Availability>.from(json["availability"]?.map((x) => Availability.fromJson(x))) : null,
    bookings: json["bookings"] != null ? List<Booking>.from(json["bookings"]?.map((x) => Booking.fromJson(x))) : null,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "amount": amount,
    "duration": duration,
    "topics": topics != null ? List<dynamic>.from(topics!.map((x) => x)) : null,
    "availability": availability != null ? List<dynamic>.from(availability!.map((x) => x.toJson())) : null,
    "bookings": bookings != null ? List<dynamic>.from(bookings!.map((x) => x.toJson())) : null,
  };
}

class Availability {
  String? id;
  DateTime? day;
  List<SlotElement>? slots;

  Availability({
    this.id,
    this.day,
    this.slots,
  });

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
    id: json["_id"],
    day: json["day"] != null ? DateTime.tryParse(json["day"]) : null,
    slots: json["slots"] != null ? List<SlotElement>.from(json["slots"]?.map((x) => SlotElement.fromJson(x))) : null,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "day": day?.toIso8601String(),
    "slots": slots != null ? List<dynamic>.from(slots!.map((x) => x.toJson())) : null,
  };
}

class SlotElement {
  String? id;
  String? startTime;
  String? endTime;
  bool? isBooked;
  String? meetingLink;
  MemberEmail? memberEmail;

  SlotElement({
    this.id,
    this.startTime,
    this.endTime,
    this.isBooked,
    this.meetingLink,
    this.memberEmail,
  });

  factory SlotElement.fromJson(Map<String, dynamic> json) => SlotElement(
    id: json["_id"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    isBooked: json["isBooked"],
    meetingLink: json["meeting_link"],
    memberEmail: json["memberEmail"] != null ? memberEmailValues.map[json["memberEmail"]] : null,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "startTime": startTime,
    "endTime": endTime,
    "isBooked": isBooked,
    "meeting_link": meetingLink,
    "memberEmail": memberEmail != null ? memberEmailValues.reverse[memberEmail!] : null,
  };
}

enum MemberEmail {
  AMANDWDI_GMAIL_COM,
  EMPTY,
  INVESTMENTS_THECAPITALHUB_IN
}

final memberEmailValues = EnumValues({
  "amandwdi@gmail.com": MemberEmail.AMANDWDI_GMAIL_COM,
  "": MemberEmail.EMPTY,
  "investments@thecapitalhub.in": MemberEmail.INVESTMENTS_THECAPITALHUB_IN,
});

class Booking {
  String? id;
  UserId? userId;
  BookingSlot? slot;
  Payment? payment;
  DateTime? createdAt;

  Booking({
    this.id,
    this.userId,
    this.slot,
    this.payment,
    this.createdAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["_id"],
    userId: json["userId"] != null ? UserId.fromJson(json["userId"]) : null,
    slot: json["slot"] != null ? BookingSlot.fromJson(json["slot"]) : null,
    payment: json["payment"] != null ? Payment.fromJson(json["payment"]) : null,
    createdAt: json["createdAt"] != null ? DateTime.tryParse(json["createdAt"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId?.toJson(),
    "slot": slot?.toJson(),
    "payment": payment?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
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
    paymentId: json["paymentId"],
    orderId: json["orderId"],
    status: json["status"],
    amount: json["amount"],
    paymentTime: json["paymentTime"],
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
  DateTime? day;
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
    day: json["day"] != null ? DateTime.tryParse(json["day"]) : null,
    startTime: json["startTime"],
    endTime: json["endTime"],
    meetingLink: json["meeting_link"],
  );

  Map<String, dynamic> toJson() => {
    "day": day?.toIso8601String(),
    "startTime": startTime,
    "endTime": endTime,
    "meeting_link": meetingLink,
  };
}

class UserId {
  Id? id;
  FirstName? firstName;
  LastName? lastName;
  String? profilePicture;

  UserId({
    this.id,
    this.firstName,
    this.lastName,
    this.profilePicture,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"] != null ? idValues.map[json["_id"]] : null,
    firstName: json["firstName"] != null ? firstNameValues.map[json["firstName"]] : null,
    lastName: json["lastName"] != null ? lastNameValues.map[json["lastName"]] : null,
    profilePicture: json["profilePicture"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id != null ? idValues.reverse[id!] : null,
    "firstName": firstName != null ? firstNameValues.reverse[firstName!] : null,
    "lastName": lastName != null ? lastNameValues.reverse[lastName!] : null,
    "profilePicture": profilePicture,
  };
}

enum FirstName {
  AMAN,
  NITIN,
  PRAMOD
}

final firstNameValues = EnumValues({
  "Aman": FirstName.AMAN,
  "Nitin": FirstName.NITIN,
  "Pramod": FirstName.PRAMOD,
});

enum Id {
  THE_66823_FC5_E233_B21_ACCA0_B471,
  THE_66_B72_C97_B441138_F6_E19_B781,
  THE_671_C86508_A5567_ABE4_BCF18_B
}

final idValues = EnumValues({
  "66823fc5e233b21acca0b471": Id.THE_66823_FC5_E233_B21_ACCA0_B471,
  "66b72c97b441138f6e19b781": Id.THE_66_B72_C97_B441138_F6_E19_B781,
  "671c86508a5567abe4bcf18b": Id.THE_671_C86508_A5567_ABE4_BCF18_B,
});

enum LastName {
  BADIGER,
  DWIVEDI,
  KUMAR
}

final lastNameValues = EnumValues({
  "Badiger": LastName.BADIGER,
  "Dwivedi": LastName.DWIVEDI,
  "Kumar": LastName.KUMAR,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
