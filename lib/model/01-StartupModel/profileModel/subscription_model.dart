// To parse this JSON data, do
//
//     final subscriptionModel = subscriptionModelFromJson(jsonString);

import 'dart:convert';

SubscriptionModel subscriptionModelFromJson(String str) => SubscriptionModel.fromJson(json.decode(str));

String subscriptionModelToJson(SubscriptionModel data) => json.encode(data.toJson());

class SubscriptionModel {
    bool? status;
    String? message;
    List<SubscriptionData>? data;

    SubscriptionModel({
        this.status,
        this.message,
        this.data,
    });

    factory SubscriptionModel.fromJson(Map<String, dynamic> json) => SubscriptionModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<SubscriptionData>.from(json["data"]!.map((x) => SubscriptionData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class SubscriptionData {
    String? name;
    String? orignalPrice;
    String? discountPercentage;
    String? priceWithDuration;
    int? priceForPayment;
    String? description;
    List<String>? benifits;
    bool? isPopularChoice;

    SubscriptionData({
        this.name,
        this.orignalPrice,
        this.discountPercentage,
        this.priceWithDuration,
        this.priceForPayment,
        this.description,
        this.benifits,
        this.isPopularChoice,
    });

    factory SubscriptionData.fromJson(Map<String, dynamic> json) => SubscriptionData(
        name: json["name"],
        orignalPrice: json["orignal_price"],
        discountPercentage: json["discount_percentage"],
        priceWithDuration: json["price_with_duration"],
        priceForPayment: json["price_for_payment"],
        description: json["description"],
        benifits: json["benifits"] == null ? [] : List<String>.from(json["benifits"]!.map((x) => x)),
        isPopularChoice: json["is_popular_choice"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "orignal_price": orignalPrice,
        "discount_percentage": discountPercentage,
        "price_with_duration": priceWithDuration,
        "price_for_payment": priceForPayment,
        "description": description,
        "benifits": benifits == null ? [] : List<dynamic>.from(benifits!.map((x) => x)),
        "is_popular_choice": isPopularChoice,
    };
}
