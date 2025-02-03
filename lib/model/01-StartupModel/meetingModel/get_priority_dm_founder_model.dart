// To parse this JSON data, do
//
//     final getPriorityDmFounderModel = getPriorityDmFounderModelFromJson(jsonString);

import 'dart:convert';

GetPriorityDmFounderModel getPriorityDmFounderModelFromJson(String str) => GetPriorityDmFounderModel.fromJson(json.decode(str));

String getPriorityDmFounderModelToJson(GetPriorityDmFounderModel data) => json.encode(data.toJson());

class GetPriorityDmFounderModel {
    bool status;
    String message;
    List<Founder> data;

    GetPriorityDmFounderModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetPriorityDmFounderModel.fromJson(Map<String, dynamic> json) => GetPriorityDmFounderModel(
        status: json["status"],
        message: json["message"],
        data: List<Founder>.from(json["data"].map((x) => Founder.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Founder {
    String userName;
    String userRating;
    String question;
    String answer;
    bool isAnswered;
    Payment payment;

    Founder({
        required this.userName,
        required this.userRating,
        required this.question,
        required this.answer,
        required this.isAnswered,
        required this.payment,
    });

    factory Founder.fromJson(Map<String, dynamic> json) => Founder(
        userName: json["UserName"],
        userRating: json["UserRating"],
        question: json["question"],
        answer: json["answer"],
        isAnswered: json["isAnswered"],
        payment: Payment.fromJson(json["payment"]),
    );

    Map<String, dynamic> toJson() => {
        "UserName": userName,
        "UserRating": userRating,
        "question": question,
        "answer": answer,
        "isAnswered": isAnswered,
        "payment": payment.toJson(),
    };
}

class Payment {
    Payment();

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    );

    Map<String, dynamic> toJson() => {
    };
}
