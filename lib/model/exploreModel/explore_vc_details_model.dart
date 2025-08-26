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
  VCData? data;

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
  String? email;
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
  List<Person>? people;

  VCData({
    this.id,
    this.name,
    this.email,
    this.logo,
    this.location,
    this.stageFocus,
    this.sectorFocus,
    this.ticketSize,
    this.age,
    this.description,
    this.currentFundCorpus,
    this.linkedin,
    this.people,
    this.totalPortfolio,
    this.totalFundCorpus,
  });

  factory VCData.fromJson(Map<String, dynamic> json) => VCData(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        logo: json["logo"],
        location: json["location"],
        stageFocus: List<String>.from(json["stage_focus"].map((x) => x)),
        sectorFocus: List<String>.from(json["sector_focus"].map((x) => x)),
        ticketSize: json["ticket_size"],
        age: json["age"].toString(),
        description: json["description"],
        currentFundCorpus: json["current_fund_corpus"].toString(),
        people: json["people"] == null
            ? []
            : List<Person>.from(json["people"]!.map((x) => Person.fromJson(x))),
        linkedin: json["linkedin"],
        totalPortfolio: json["total_portfolio"].toString(),
        totalFundCorpus: json["total_fund_corpus"].toString(),
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

class Person {
  String? id;
  String? cName;
  String? cEmail;
  String? cLinkedin;

  Person({
    this.id,
    this.cName,
    this.cEmail,
    this.cLinkedin,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["_id"],
        cName: json["c_name"],
        cEmail: json["c_email"],
        cLinkedin: json["c_linkedin"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "c_name": cName,
        "c_email": cEmail,
        "c_linkedin": cLinkedin,
      };
}
