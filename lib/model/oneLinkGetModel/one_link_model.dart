// // To parse this JSON data, do
// //
// //     final oneLinkGetModel = oneLinkGetModelFromJson(jsonString);

// import 'dart:convert';

// import 'package:flutter/material.dart';

// OneLinkGetModel oneLinkGetModelFromJson(String str) =>
//     OneLinkGetModel.fromJson(json.decode(str));

// String oneLinkGetModelToJson(OneLinkGetModel data) =>
//     json.encode(data.toJson());

// class OneLinkGetModel {
//   bool? status;
//   String? message;
//   OneLinkData? data;

//   OneLinkGetModel({
//     this.status,
//     this.message,
//     this.data,
//   });

//   factory OneLinkGetModel.fromJson(Map<String, dynamic> json) =>
//       OneLinkGetModel(
//         status: json["status"],
//         message: json["message"],
//         data: OneLinkData.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data!.toJson(),
//       };
// }

// class OneLinkData {
//   String? startUpId;
//   String? investorId;
//   String? name;
//   String? oneLink;
//   String? introductoryMessage;
//   String? secretOneLinkKey;
//   List<String>? previousIntroductoryMessage;
//   List<Thesis>? thesis;
//   String? investmentPhilosophy;

//   OneLinkData({
//     this.startUpId,
//     this.investorId,
//     this.name,
//     this.oneLink,
//     this.introductoryMessage,
//     this.secretOneLinkKey,
//     this.previousIntroductoryMessage,
//     this.thesis,
//     this.investmentPhilosophy,
//   });

//   factory OneLinkData.fromJson(Map<String, dynamic> json) => OneLinkData(
//         startUpId: json["startUpId"],
//         investorId: json["investorId"],
//         name: json["name"],
//         oneLink: json["oneLink"],
//         introductoryMessage: json["introductoryMessage"],
//         secretOneLinkKey: json["secretOneLinkKey"],
//         previousIntroductoryMessage: List<String>.from(
//             json["previousIntroductoryMessage"].map((x) => x)),
//         thesis:
//             List<Thesis>.from(json["thesis"].map((x) => Thesis.fromJson(x))),
//         investmentPhilosophy: json["investmentPhilosophy"],
//       );

//   Map<String, dynamic> toJson() => {
//         "startUpId": startUpId,
//         "investorId": investorId,
//         "name": name,
//         "oneLink": oneLink,
//         "introductoryMessage": introductoryMessage,
//         "secretOneLinkKey": secretOneLinkKey,
//         "previousIntroductoryMessage":
//             List<dynamic>.from(previousIntroductoryMessage!.map((x) => x)),
//         "thesis": List<dynamic>.from(thesis!.map((x) => x.toJson())),
//         "investmentPhilosophy": investmentPhilosophy,
//       };
// }

// class Thesis {
//   String? question;
//   TextEditingController? answer;

//   Thesis({
//     this.question,
//     this.answer,
//   });

//   factory Thesis.fromJson(Map<String, dynamic> json) => Thesis(
//         question: json["question"],
//         answer: TextEditingController(text: json["answer"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "question": question,
//         "answer": answer!.text,
//       };
// }

import 'dart:convert';
import 'package:flutter/material.dart';

OneLinkGetModel oneLinkGetModelFromJson(String str) =>
    OneLinkGetModel.fromJson(json.decode(str));

String oneLinkGetModelToJson(OneLinkGetModel data) =>
    json.encode(data.toJson());

class OneLinkGetModel {
  bool? status;
  String? message;
  OneLinkData? data;

  OneLinkGetModel({
    this.status,
    this.message,
    this.data,
  });

  factory OneLinkGetModel.fromJson(Map<String, dynamic> json) =>
      OneLinkGetModel(
        status: json.containsKey("status") ? json["status"] : false,
        message: json.containsKey("message") ? json["message"] : "",
        data: json.containsKey("data") && json["data"] != null
            ? OneLinkData.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status ?? false,
        "message": message ?? "",
        "data": data?.toJson(),
      };
}

class OneLinkData {
  String? startUpId;
  String? investorId;
  String? name;
  String? oneLink;
  String? introductoryMessage;
  String? secretOneLinkKey;
  List<String>? previousIntroductoryMessage;
  List<Thesis>? thesis;
  String? investmentPhilosophy;

  OneLinkData({
    this.startUpId,
    this.investorId,
    this.name,
    this.oneLink,
    this.introductoryMessage,
    this.secretOneLinkKey,
    this.previousIntroductoryMessage,
    this.thesis,
    this.investmentPhilosophy,
  });

  factory OneLinkData.fromJson(Map<String, dynamic> json) => OneLinkData(
        startUpId: json.containsKey("startUpId") ? json["startUpId"] : "",
        investorId: json.containsKey("investorId") ? json["investorId"] : "",
        name: json.containsKey("name") ? json["name"] : "",
        oneLink: json.containsKey("oneLink") ? json["oneLink"] : "",
        introductoryMessage: json.containsKey("introductoryMessage") ? json["introductoryMessage"] : "",
        secretOneLinkKey: json.containsKey("secretOneLinkKey") ? json["secretOneLinkKey"] : "",
        previousIntroductoryMessage: json.containsKey("previousIntroductoryMessage")
            ? List<String>.from(json["previousIntroductoryMessage"].map((x) => x))
            : [],
        thesis: json.containsKey("thesis")
            ? (json["thesis"] != null
                ? List<Thesis>.from(json["thesis"].map((x) => Thesis.fromJson(x)))
                : [])
            : [],
        investmentPhilosophy: json.containsKey("investmentPhilosophy") ? json["investmentPhilosophy"] : "",
      );

  Map<String, dynamic> toJson() => {
        "startUpId": startUpId ?? "",
        "investorId": investorId ?? "",
        "name": name ?? "",
        "oneLink": oneLink ?? "",
        "introductoryMessage": introductoryMessage ?? "",
        "secretOneLinkKey": secretOneLinkKey ?? "",
        "previousIntroductoryMessage": previousIntroductoryMessage != null
            ? List<dynamic>.from(previousIntroductoryMessage!.map((x) => x))
            : [],
        "thesis": thesis != null
            ? List<dynamic>.from(thesis!.map((x) => x.toJson()))
            : [],
        "investmentPhilosophy": investmentPhilosophy ?? "",
      };
}

class Thesis {
  String? question;
  TextEditingController? answer;

  Thesis({
    this.question,
    this.answer,
  });

  factory Thesis.fromJson(Map<String, dynamic> json) => Thesis(
        question: json.containsKey("question") ? json["question"] : "",
        answer: json.containsKey("answer")
            ? TextEditingController(text: json["answer"])
            : TextEditingController(text: ""),
      );

  Map<String, dynamic> toJson() => {
        "question": question ?? "",
        "answer": answer?.text ?? "",
      };
}
