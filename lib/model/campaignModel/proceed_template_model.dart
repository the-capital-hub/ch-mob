// To parse this JSON data, do
//
//     final proceedTemplateModel = proceedTemplateModelFromJson(jsonString);

import 'dart:convert';

ProceedTemplateModel proceedTemplateModelFromJson(String str) => ProceedTemplateModel.fromJson(json.decode(str));

String proceedTemplateModelToJson(ProceedTemplateModel data) => json.encode(data.toJson());

class ProceedTemplateModel {
    bool? status;
    String? message;
    ProceedTemplateData? data;

    ProceedTemplateModel({
        this.status,
        this.message,
        this.data,
    });

    factory ProceedTemplateModel.fromJson(Map<String, dynamic> json) => ProceedTemplateModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : ProceedTemplateData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class ProceedTemplateData {
    String? noOfList;
    String? totalInvestor;
    String? templateName;
    String? templateSubject;
    String? templateContent;
    String? totalVc;
    List<String>? cc;

    ProceedTemplateData({
        this.noOfList,
        this.totalInvestor,
        this.templateName,
        this.templateSubject,
        this.templateContent,
        this.totalVc,
        this.cc,
    });

    factory ProceedTemplateData.fromJson(Map<String, dynamic> json) => ProceedTemplateData(
        noOfList: json["no_of_list"].toString(),
        totalInvestor: json["total_investor"].toString(),
        templateName: json["template_name"],
        templateSubject: json["template_subject"],
        templateContent: json["template_content"],
        totalVc: json["total_vc"].toString(),
        cc: json["cc"] == null ? [] : List<String>.from(json["cc"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "no_of_list": noOfList,
        "total_investor": totalInvestor,
        "template_name": templateName,
        "template_subject": templateSubject,
        "template_content": templateContent,
        "cc": cc == null ? [] : List<dynamic>.from(cc!.map((x) => x)),
    };
}
