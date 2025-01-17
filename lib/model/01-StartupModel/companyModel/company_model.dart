// To parse this JSON data, do
//
//     final companyModel = companyModelFromJson(jsonString);

import 'dart:convert';

CompanyModel companyModelFromJson(String str) =>
    CompanyModel.fromJson(json.decode(str));

String companyModelToJson(CompanyModel data) => json.encode(data.toJson());

class CompanyModel {
  bool? status;
  String? message;
  CompanyData? data;

  CompanyModel({
    this.status,
    this.message,
    this.data,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        status: json["status"],
        message: json["message"],
        data: CompanyData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class CompanyData {
  String? id;
  String? logo;
  String? name;
  String? tagline;
  String? location;
  String? foundingDate;
  String? lastFunding;
  String? stage;
  String? sector;
  String? description;
  String? numberOfEmployees;
  String? vision;
  String? mission;
  String? tam;
  String? som;
  String? sam;
  String? lastRoundInvestment;
  String? totalInvestment;
  String? noOfInvesters;
  String? fundAsk;
  String? valuation;
  String? raisedFunds;
  String? lastYearRevenue;
  String? target;
  List<SocialLink>? socialLinks;
  List<String>? keyFocus;
  List<Team>? team;
  bool? isOwnCompany;

  CompanyData({
    this.id,
    this.logo,
    this.name,
    this.tagline,
    this.location,
    this.foundingDate,
    this.lastFunding,
    this.stage,
    this.sector,
    this.description,
    this.numberOfEmployees,
    this.vision,
    this.mission,
    this.tam,
    this.som,
    this.sam,
    this.lastRoundInvestment,
    this.totalInvestment,
    this.noOfInvesters,
    this.fundAsk,
    this.valuation,
    this.raisedFunds,
    this.lastYearRevenue,
    this.target,
    this.socialLinks,
    this.keyFocus,
    this.team,
    this.isOwnCompany,
  });

  factory CompanyData.fromJson(Map<String, dynamic> json) => CompanyData(
        id: json["startUpId"],
        logo: json["logo"],
        name: json["name"],
        tagline: json["tagline"],
        location: json["location"],
        foundingDate: json["foundingDate"],
        lastFunding: json["lastFunding"],
        stage: json["stage"],
        sector: json["sector"],
        description: json["description"],
        numberOfEmployees: json["numberOfEmployees"].toString(),
        vision: json["vision"],
        mission: json["mission"],
        tam: json["TAM"],
        som: json["SOM"],
        sam: json["SAM"],
        lastRoundInvestment: json["lastRoundInvestment"],
        totalInvestment: json["totalInvestment"],
        noOfInvesters: json["noOfInvesters"],
        fundAsk: json["fundAsk"],
        valuation: json["valuation"],
        raisedFunds: json["raisedFunds"],
        lastYearRevenue: json["lastYearRevenue"],
        target: json["target"],
        socialLinks: List<SocialLink>.from(
            json["socialLinks"].map((x) => SocialLink.fromJson(x))),
        keyFocus: List<String>.from(json["keyFocus"]),
        team: List<Team>.from(json["team"].map((x) => Team.fromJson(x))),
        isOwnCompany: json["isOwnCompany"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "tagline": tagline,
        "location": location,
        "foundingDate": foundingDate,
        "lastFunding": lastFunding,
        "stage": stage,
        "sector": sector,
        "description": description,
        "numberOfEmployees": numberOfEmployees,
        "vision": vision,
        "mission": mission,
        "TAM": tam,
        "SOM": som,
        "SAM": sam,
        "lastRoundInvestment": lastRoundInvestment,
        "totalInvestment": totalInvestment,
        "noOfInvesters": noOfInvesters,
        "fundAsk": fundAsk,
        "valuation": valuation,
        "raisedFunds": raisedFunds,
        "lastYearRevenue": lastYearRevenue,
        "target": target,
        "socialLinks": List<dynamic>.from(socialLinks!.map((x) => x.toJson())),
        "keyFocus": keyFocus,
        "team": List<dynamic>.from(team!.map((x) => x.toJson())),
        "isOwnCompany": isOwnCompany,
      };
}

class SocialLink {
  String? name;
  String? link;
  String? logo;

  SocialLink({
    this.name,
    this.link,
    this.logo,
  });

  factory SocialLink.fromJson(Map<String, dynamic> json) => SocialLink(
        name: json["name"],
        link: json["link"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "link": link,
        "logo": logo,
      };
}

class Team {
  String? name;
  String? designation;
  String? image;

  Team({
    this.name,
    this.designation,
    this.image,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        name: json["name"],
        designation: json["designation"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "designation": designation,
        "image": image,
      };
}
