// To parse this JSON data, do
//
//     final templateViewModel = templateViewModelFromJson(jsonString);

import 'dart:convert';

TemplateViewModel templateViewModelFromJson(String str) =>
    TemplateViewModel.fromJson(json.decode(str));

String templateViewModelToJson(TemplateViewModel data) =>
    json.encode(data.toJson());

class TemplateViewModel {
  List<TemplateList>? data;
  bool? status;
  String? message;

  TemplateViewModel({
    this.data,
    this.status,
    this.message,
  });

  factory TemplateViewModel.fromJson(Map<String, dynamic> json) =>
      TemplateViewModel(
        data: json["data"] == null
            ? []
            : List<TemplateList>.from(
                json["data"]!.map((x) => TemplateList.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class TemplateList {
  String? templateId;
  String? templateName;
  String? templateSubject;
  String? emailBody;
  String? folder;
  String? visibility;
  String? pricingType;
  String? price;
  String? createdBy;

  TemplateList({
    this.templateId,
    this.templateName,
    this.templateSubject,
    this.emailBody,
    this.folder,
    this.visibility,
    this.pricingType,
    this.price,
    this.createdBy,
  });

  factory TemplateList.fromJson(Map<String, dynamic> json) => TemplateList(
        templateId: json["templateId"],
        templateName: json["templateName"],
        templateSubject: json["templateSubject"],
        emailBody: json['emailBody'],
        folder: json["folder"],
        visibility: json["visibility"],
        pricingType: json["pricingType"],
        price: json["price"].toString(),
        createdBy: json["createdBy"],
      );

  Map<String, dynamic> toJson() => {
        "templateId": templateId,
        "templateName": templateName,
        "templateSubject": templateSubject,
        "createdBy": createdBy,
      };
}
