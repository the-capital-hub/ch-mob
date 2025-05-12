// To parse this JSON data, do
//
//     final exploreFilterModel = exploreFilterModelFromJson(jsonString);

import 'dart:convert';

ExploreFilterModel exploreFilterModelFromJson(String str) =>
    ExploreFilterModel.fromJson(json.decode(str));

String exploreFilterModelToJson(ExploreFilterModel data) =>
    json.encode(data.toJson());

class ExploreFilterModel {
  bool? status;
  String? message;
  Data? data;

  ExploreFilterModel({
    this.status,
    this.message,
    this.data,
  });

  factory ExploreFilterModel.fromJson(Map<String, dynamic> json) =>
      ExploreFilterModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  List<String>? cities;

  Data({
    this.cities,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cities: List<String>.from(json["cities"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "cities": List<dynamic>.from(cities!.map((x) => x)),
      };
}
