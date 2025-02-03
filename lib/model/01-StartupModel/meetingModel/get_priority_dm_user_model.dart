// To parse this JSON data, do
//
//     final getPriorityDmUserModel = getPriorityDmUserModelFromJson(jsonString);

import 'dart:convert';

GetPriorityDmUserModel getPriorityDmUserModelFromJson(String str) => GetPriorityDmUserModel.fromJson(json.decode(str));

String getPriorityDmUserModelToJson(GetPriorityDmUserModel data) => json.encode(data.toJson());

class GetPriorityDmUserModel {
    bool status;
    String message;
    List<User> data;

    GetPriorityDmUserModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetPriorityDmUserModel.fromJson(Map<String, dynamic> json) => GetPriorityDmUserModel(
        status: json["status"],
        message: json["message"],
        data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class User {
    String founderName;
    String founderRating;
    String question;
    String answer;
    bool isAnswered;
    Payment payment;

    User({
        required this.founderName,
        required this.founderRating,
        required this.question,
        required this.answer,
        required this.isAnswered,
        required this.payment,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        founderName: json["FounderName"],
        founderRating: json["FounderRating"],
        question: json["question"],
        answer: json["answer"],
        isAnswered: json["isAnswered"],
        payment: Payment.fromJson(json["payment"]),
    );

    Map<String, dynamic> toJson() => {
        "FounderName": founderName,
        "FounderRating": founderRating,
        "question": question,
        "answer": answer,
        "isAnswered": isAnswered,
        "payment": payment.toJson(),
    };
}

class Payment {
    String? paymentId;
    String? orderId;
    String? status;
    int? amount;
    DateTime? paymentTime;

    Payment({
        this.paymentId,
        this.orderId,
        this.status,
        this.amount,
        this.paymentTime,
    });

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        paymentId: json["paymentId"],
        orderId: json["orderId"],
        status: json["status"],
        amount: json["amount"],
        paymentTime: json["paymentTime"] == null ? null : DateTime.parse(json["paymentTime"]),
    );

    Map<String, dynamic> toJson() => {
        "paymentId": paymentId,
        "orderId": orderId,
        "status": status,
        "amount": amount,
        "paymentTime": paymentTime?.toIso8601String(),
    };
}
