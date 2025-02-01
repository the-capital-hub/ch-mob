// To parse this JSON data, do
//
//     final getAvailabilityModel = getAvailabilityModelFromJson(jsonString);

import 'dart:convert';

GetAvailabilityModel getAvailabilityModelFromJson(String str) => GetAvailabilityModel.fromJson(json.decode(str));

String getAvailabilityModelToJson(GetAvailabilityModel data) => json.encode(data.toJson());

class GetAvailabilityModel {
    bool status;
    String message;
    Availability data;

    GetAvailabilityModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetAvailabilityModel.fromJson(Map<String, dynamic> json) => GetAvailabilityModel(
        status: json["status"],
        message: json["message"],
        data: Availability.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Availability {
    String minimumGap;
    List<DayAvailability> dayAvailability;

    Availability({
        required this.minimumGap,
        required this.dayAvailability,
    });

    factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        minimumGap: json["minimumGap"],
        dayAvailability: List<DayAvailability>.from(json["dayAvailability"].map((x) => DayAvailability.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "minimumGap": minimumGap,
        "dayAvailability": List<dynamic>.from(dayAvailability.map((x) => x.toJson())),
    };
}

class DayAvailability {
    String day;
    String startTime;
    String endTime;

    DayAvailability({
        required this.day,
        required this.startTime,
        required this.endTime,
    });

    factory DayAvailability.fromJson(Map<String, dynamic> json) => DayAvailability(
        day: json["day"],
        startTime: json["startTime"],
        endTime: json["endTime"],
    );

    Map<String, dynamic> toJson() => {
        "day": day,
        "startTime": startTime,
        "endTime": endTime,
    };
}
