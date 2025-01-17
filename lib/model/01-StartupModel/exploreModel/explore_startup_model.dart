// To parse this JSON data, do
//
//     final exploreStartupModel = exploreStartupModelFromJson(jsonString);

import 'dart:convert';

ExploreStartupModel exploreStartupModelFromJson(String str) =>
    ExploreStartupModel.fromJson(json.decode(str));

String exploreStartupModelToJson(ExploreStartupModel data) =>
    json.encode(data.toJson());

class ExploreStartupModel {
  bool? status;
  String? message;
  List<StartupExplore>? data;

  ExploreStartupModel({
    this.status,
    this.message,
    this.data,
  });

  factory ExploreStartupModel.fromJson(Map<String, dynamic> json) =>
      ExploreStartupModel(
        status: json["status"],
        message: json["message"],
        data: List<StartupExplore>.from(
            json["data"].map((x) => StartupExplore.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class StartupExplore {
  String? id;
  String? fundAsk;
  String? valuation;
  String? raisedFunds;
  List<SocialLink>? socialLinks;
  String? company;
  String? description;
  String? sector;
  String? tagline;
  String? stage;
  String? lastFunding;
  String? location;
  String? logo;
  String? tam;
  String? sam;
  String? som;
  int? noOfEmployees;
  String? startedAtDate;
  List<String>? keyFocus;

  StartupExplore({
    this.id,
    this.fundAsk,
    this.valuation,
    this.raisedFunds,
    this.socialLinks,
    this.company,
    this.description,
    this.sector,
    this.tagline,
    this.stage,
    this.lastFunding,
    this.location,
    this.logo,
    this.tam,
    this.sam,
    this.som,
    this.noOfEmployees,
    this.startedAtDate,
    this.keyFocus,
  });

  factory StartupExplore.fromJson(Map<String, dynamic> json) => StartupExplore(
        id: json["_id"],
        fundAsk: json["fund_ask"],
        valuation: json["valuation"],
        raisedFunds: json["raised_funds"],
        socialLinks: List<SocialLink>.from(
            json["socialLinks"].map((x) => SocialLink.fromJson(x))),
        company: json["company"],
        description: json["description"],
        sector: json["sector"],
        tagline: json["tagline"],
        stage: json["stage"],
        lastFunding: json["lastFunding"],
        location: json["location"],
        logo: json["logo"],
        tam: json["TAM"],
        sam: json["SAM"],
        som: json["SOM"],
        noOfEmployees: json["noOfEmployees"],
        startedAtDate: json["startedAtDate"],
        keyFocus: List<String>.from(json["keyFocus"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fund_ask": fundAsk,
        "valuation": valuation,
        "raised_funds": raisedFunds,
        "socialLinks": List<dynamic>.from(socialLinks!.map((x) => x.toJson())),
        "company": company,
        "description": description,
        "sector": sector,
        "tagline": tagline,
        "stage": stage,
        "lastFunding": lastFunding,
        "location": location,
        "logo": logo,
        "TAM": tam,
        "SAM": sam,
        "SOM": som,
        "noOfEmployees": noOfEmployees,
        "startedAtDate": startedAtDate,
        "keyFocus": List<dynamic>.from(keyFocus!.map((x) => x)),
      };
}

class SocialLink {
  String? logo;
  String? name;
  String? link;

  SocialLink({
    this.name,
    this.logo,
    this.link,
  });

  factory SocialLink.fromJson(Map<String, dynamic> json) => SocialLink(
        name: json["name"],
        logo: json["logo"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "link": link,
      };
}
