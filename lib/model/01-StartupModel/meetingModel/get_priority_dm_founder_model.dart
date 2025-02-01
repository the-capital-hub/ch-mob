// To parse this JSON data, do
//
//     final getPriorityDmFounderModel = getPriorityDmFounderModelFromJson(jsonString);

import 'dart:convert';

GetPriorityDmFounderModel getPriorityDmFounderModelFromJson(String str) => GetPriorityDmFounderModel.fromJson(json.decode(str));

String getPriorityDmFounderModelToJson(GetPriorityDmFounderModel data) => json.encode(data.toJson());

class GetPriorityDmFounderModel {
    bool status;
    String message;
    Founder data;

    GetPriorityDmFounderModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetPriorityDmFounderModel.fromJson(Map<String, dynamic> json) => GetPriorityDmFounderModel(
        status: json["status"],
        message: json["message"],
        data: Founder.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
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
    String paymentId;
    String orderId;
    String status;
    int amount;
    DateTime paymentTime;

    Payment({
        required this.paymentId,
        required this.orderId,
        required this.status,
        required this.amount,
        required this.paymentTime,
    });

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        paymentId: json["paymentId"],
        orderId: json["orderId"],
        status: json["status"],
        amount: json["amount"],
        paymentTime: DateTime.parse(json["paymentTime"]),
    );

    Map<String, dynamic> toJson() => {
        "paymentId": paymentId,
        "orderId": orderId,
        "status": status,
        "amount": amount,
        "paymentTime": paymentTime.toIso8601String(),
    };
}
