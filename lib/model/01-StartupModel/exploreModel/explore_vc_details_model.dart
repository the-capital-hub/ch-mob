// To parse this JSON data, do
//
//     final exploreVcDetailsModel = exploreVcDetailsModelFromJson(jsonString);

import 'dart:convert';

ExploreVcDetailsModel exploreVcDetailsModelFromJson(String str) =>
    ExploreVcDetailsModel.fromJson(json.decode(str));

String exploreVcDetailsModelToJson(ExploreVcDetailsModel data) =>
    json.encode(data.toJson());

class ExploreVcDetailsModel {
  bool? status;
  String? message;
  VCData ?data;

  ExploreVcDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  factory ExploreVcDetailsModel.fromJson(Map<String, dynamic> json) =>
      ExploreVcDetailsModel(
        status: json["status"],
        message: json["message"],
        data: VCData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class VCData {
  String? id;
  String? name;
  String? logo;
  String? location;
  List<String>? stageFocus;
  List<String>? sectorFocus;
  String? ticketSize;
  String? age;
  String? description;
  String? currentFundCorpus;
  String? linkedin;
  String? totalPortfolio;
  String? totalFundCorpus;

  VCData({
    this.id,
    this.name,
    this.logo,
    this.location,
    this.stageFocus,
    this.sectorFocus,
    this.ticketSize,
    this.age,
    this.description,
    this.currentFundCorpus,
    this.linkedin,
    this.totalPortfolio,
    this.totalFundCorpus,
  });

  factory VCData.fromJson(Map<String, dynamic> json) => VCData(
        id: json["_id"],
        name: json["name"],
        logo: json["logo"],
        location: json["location"],
        stageFocus: List<String>.from(json["stage_focus"].map((x) => x)),
        sectorFocus: List<String>.from(json["sector_focus"].map((x) => x)),
        ticketSize: json["ticket_size"],
        age: json["age"].toString(),
        description: json["description"],
        currentFundCorpus: json["current_fund_corpus"],
        linkedin: json["linkedin"],
        totalPortfolio: json["total_portfolio"],
        totalFundCorpus: json["total_fund_corpus"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "logo": logo,
        "location": location,
        "stage_focus": List<dynamic>.from(stageFocus!.map((x) => x)),
        "sector_focus": List<dynamic>.from(sectorFocus!.map((x) => x)),
        "ticket_size": ticketSize,
        "age": age,
        "description": description,
        "current_fund_corpus": currentFundCorpus,
        "linkedin": linkedin,
        "total_portfolio": totalPortfolio,
        "total_fund_corpus": totalFundCorpus,
      };
}
