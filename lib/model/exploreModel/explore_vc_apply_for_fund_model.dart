// To parse this JSON data, do
//
//     final applyForFund = applyForFundFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

ApplyForFund applyForFundFromJson(String str) =>
    ApplyForFund.fromJson(json.decode(str));

String applyForFundToJson(ApplyForFund data) => json.encode(data.toJson());

class ApplyForFund {
  bool? status;
  List<FundQuestions>? data;
  String? message;

  ApplyForFund({
    this.status,
    this.data,
    this.message,
  });

  factory ApplyForFund.fromJson(Map<String, dynamic> json) => ApplyForFund(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<FundQuestions>.from(
                json["data"]!.map((x) => FundQuestions.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class FundQuestions {
  String? question;
  String? subTitle;
  TextEditingController answer;

  FundQuestions({
    this.question,
    this.subTitle,
    required this.answer,
  });

  factory FundQuestions.fromJson(Map<String, dynamic> json) => FundQuestions(
        question: json["question"],
        subTitle: json["subTitle"],
        answer: TextEditingController(text: json["answer"]),
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "subTitle": subTitle,
        "answer": answer.text,
      };
}
