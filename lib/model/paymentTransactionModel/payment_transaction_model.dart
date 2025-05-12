// To parse this JSON data, do
//
//     final paymentTransactionModel = paymentTransactionModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

PaymentTransactionModel paymentTransactionModelFromJson(String str) => PaymentTransactionModel.fromJson(json.decode(str));

String paymentTransactionModelToJson(PaymentTransactionModel data) => json.encode(data.toJson());

class PaymentTransactionModel {
    bool? status;
    String? message;
    PaymentData? data;

    PaymentTransactionModel({
        this.status,
        this.message,
        this.data,
    });

    factory PaymentTransactionModel.fromJson(Map<String, dynamic> json) => PaymentTransactionModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : PaymentData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class PaymentData {
    List<PaymentDetail>? paymentDetails;
    Summary? summary;

    PaymentData({
        this.paymentDetails,
        this.summary,
    });

    factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
        paymentDetails: json["paymentDetails"] == null ? [] : List<PaymentDetail>.from(json["paymentDetails"]!.map((x) => PaymentDetail.fromJson(x))),
        summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
    );

    Map<String, dynamic> toJson() => {
        "paymentDetails": paymentDetails == null ? [] : List<dynamic>.from(paymentDetails!.map((x) => x.toJson())),
        "summary": summary?.toJson(),
    };
}

class PaymentDetail {
    String? name;
    String? email;
    String? phone;
    String? service;
    String? subService;
    String? amount;
    String? date;
    String? paymentType;
    String? paymentInfo;
    String? bankName;
    String? orderId;
    String? status;

    PaymentDetail({
        this.name,
        this.email,
        this.phone,
        this.service,
        this.subService,
        this.amount,
        this.date,
        this.paymentType,
        this.paymentInfo,
        this.bankName,
        this.orderId,
        this.status,
    });

    factory PaymentDetail.fromJson(Map<String, dynamic> json) => PaymentDetail(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        service: json["service"],
        subService: json["subService"],
        amount: json["amount"],
        date: json["date"],
        paymentType: json["paymentType"],
        paymentInfo: json["paymentInfo"],
        bankName:json["bankName"],
        orderId: json["orderId"],
        status: json["status"].toString().capitalizeFirst,
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email":email,
        "phone": phone,
        "service": service,
        "subService": subService,
        "amount": amount,
        "date": date,
        "paymentType": paymentType,
        "paymentInfo": paymentInfo,
        "bankName": bankName,
        "orderId": orderId,
        "status": status,
    };
}



class Summary {
    bool? show;
    int? totalTransactions;
    int? successfulPayments;
    String? totalRevenue;

    Summary({
        this.show,
        this.totalTransactions,
        this.successfulPayments,
        this.totalRevenue,
    });

    factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        show: json["show"],
        totalTransactions: json["totalTransactions"],
        successfulPayments: json["successfulPayments"],
        totalRevenue: json["totalRevenue"],
    );

    Map<String, dynamic> toJson() => {
        "show": show,
        "totalTransactions": totalTransactions,
        "successfulPayments": successfulPayments,
        "totalRevenue": totalRevenue,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
