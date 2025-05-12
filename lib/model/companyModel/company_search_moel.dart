// To parse this JSON data, do
//
//     final companySearchModel = companySearchModelFromJson(jsonString);

import 'dart:convert';

CompanySearchModel companySearchModelFromJson(String str) =>
    CompanySearchModel.fromJson(json.decode(str));

String companySearchModelToJson(CompanySearchModel data) =>
    json.encode(data.toJson());

class CompanySearchModel {
  bool? status;
  String? message;
  List<CompanyList>? data;

  CompanySearchModel({
    this.status,
    this.message,
    this.data,
  });

  factory CompanySearchModel.fromJson(Map<String, dynamic> json) =>
      CompanySearchModel(
        status: json["status"],
        message: json["message"],
        data: List<CompanyList>.from(
            json["data"].map((x) => CompanyList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CompanyList {
  String? id;
  String? company;
  String? logo;
  bool? isFounder;

  CompanyList({this.id, this.company, this.logo, this.isFounder});

  factory CompanyList.fromJson(Map<String, dynamic> json) => CompanyList(
        id: json["startUpId"],
        company: json["name"],
        logo: json["logo"],
        isFounder: json["isFounder"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "company": company,
      };
}
