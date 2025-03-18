import 'dart:convert';

// To parse this JSON data, do
//
//     final getCommunityPriorityDMsModel = getCommunityPriorityDMsModelFromJson(jsonString);

GetCommunityPriorityDMsModel getCommunityPriorityDMsModelFromJson(String str) =>
    GetCommunityPriorityDMsModel.fromJson(json.decode(str));

String getCommunityPriorityDMsModelToJson(GetCommunityPriorityDMsModel data) =>
    json.encode(data.toJson());

class GetCommunityPriorityDMsModel {
  final bool? status;
  final String? message;
  final List<CommunityPriorityDMs>? data;

  GetCommunityPriorityDMsModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetCommunityPriorityDMsModel.fromJson(Map<String, dynamic> json) =>
      GetCommunityPriorityDMsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null
            ? List<CommunityPriorityDMs>.from(json["data"].map((x) => CommunityPriorityDMs.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : null,
      };
}

class CommunityPriorityDMs {
  final String? id;
  final String? title;
  final String? description;
  final int? amount;
  final int? timeline;
  final List<String>? topics;
  final List<Question>? questions;

  CommunityPriorityDMs({
    this.id,
    this.title,
    this.description,
    this.amount,
    this.timeline,
    this.topics,
    this.questions,
  });

  factory CommunityPriorityDMs.fromJson(Map<String, dynamic> json) => CommunityPriorityDMs(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        amount: json["amount"],
        timeline: json["timeline"],
        topics: json["topics"] != null ? List<String>.from(json["topics"].map((x) => x)) : null,
        questions: json["questions"] != null
            ? List<Question>.from(json["questions"].map((x) => Question.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "amount": amount,
        "timeline": timeline,
        "topics": topics != null ? List<dynamic>.from(topics!.map((x) => x)) : null,
        "questions": questions != null ? List<dynamic>.from(questions!.map((x) => x.toJson())) : null,
      };
}

class Question {
  final String? id;
  final UserId? userId;
  final String? question;
  final String? answer;
  final bool? isAnswered;
  final Payment? payment;
  final String? createdAt;

  Question({
    this.id,
    this.userId,
    this.question,
    this.answer,
    this.isAnswered,
    this.payment,
    this.createdAt,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["_id"],
        userId: json["userId"] != null ? UserId.fromJson(json["userId"]) : null,
        question: json["question"],
        answer: json["answer"],
        isAnswered: json["isAnswered"],
        payment: json["payment"] != null ? Payment.fromJson(json["payment"]) : null,
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId?.toJson(),
        "question": question,
        "answer": answer,
        "isAnswered": isAnswered,
        "payment": payment?.toJson(),
        "createdAt": createdAt,
      };
}

class Payment {
  final String? paymentId;
  final String? orderId;
  final String? status;
  final int? amount;
  final dynamic paymentTime;

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
        paymentTime: json["paymentTime"],
      );

  Map<String, dynamic> toJson() => {
        "paymentId": paymentId,
        "orderId": orderId,
        "status": status,
        "amount": amount,
        "paymentTime": paymentTime,
      };
}

class UserId {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? profilePicture;

  UserId({
    this.id,
    this.firstName,
    this.lastName,
    this.profilePicture,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePicture: json["profilePicture"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture,
      };
}
