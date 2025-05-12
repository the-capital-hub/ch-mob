// To parse this JSON data, do
//
//     final exploreVcDetailsModel = exploreVcDetailsModelFromJson(jsonString);

import 'dart:convert';

ExploreVcModel exploreVcDetailsModelFromJson(String str) =>
    ExploreVcModel.fromJson(json.decode(str));

String exploreVcDetailsModelToJson(ExploreVcModel data) =>
    json.encode(data.toJson());

class ExploreVcModel {
  bool? status;
  String? message;
  List<VcDetail>? data;

  ExploreVcModel({
    this.status,
    this.message,
    this.data,
  });

  factory ExploreVcModel.fromJson(Map<String, dynamic> json) => ExploreVcModel(
        status: json["status"],
        message: json["message"],
        data:
            List<VcDetail>.from(json["data"].map((x) => VcDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class VcDetail {
  String? id;
  String? name;
  String? logo;
  String? location;
  bool isChecked = false;
  List<String>? stageFocus;
  List<String>? sectorFocus;
  String? ticketSize;
  int? age;

  VcDetail({
    this.id,
    this.name,
    this.logo,
    this.location,
    this.stageFocus,
    this.sectorFocus,
    this.ticketSize,
    this.age,
  });

  factory VcDetail.fromJson(Map<String, dynamic> json) => VcDetail(
        id: json["_id"],
        name: json["name"],
        logo: json["logo"],
        location: json["location"],
        stageFocus: List<String>.from(json["stage_focus"].map((x) => x ?? "")),
        sectorFocus: List<String>.from(json["sector_focus"].map((x) => x)),
        ticketSize: json["ticket_size"],
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "location": location,
        "stage_focus": List<dynamic>.from(stageFocus!.map((x) => x)),
        "sector_focus": List<dynamic>.from(sectorFocus!.map((x) => x)),
        "ticket_size": ticketSize,
        "age": age,
      };
}
