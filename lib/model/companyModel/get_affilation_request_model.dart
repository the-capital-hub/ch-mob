// To parse this JSON data, do
//
//     final getAffilationRequestModel = getAffilationRequestModelFromJson(jsonString);

import 'dart:convert';

GetAffilationRequestModel getAffilationRequestModelFromJson(String str) =>
    GetAffilationRequestModel.fromJson(json.decode(str));

String getAffilationRequestModelToJson(GetAffilationRequestModel data) =>
    json.encode(data.toJson());

class GetAffilationRequestModel {
  bool? status;
  String? message;
  AffilationReqData? data;

  GetAffilationRequestModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetAffilationRequestModel.fromJson(Map<String, dynamic> json) =>
      GetAffilationRequestModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : AffilationReqData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class AffilationReqData {
  bool? isFounder;
  List<Request>? requests;

  AffilationReqData({
    this.isFounder,
    this.requests,
  });

  factory AffilationReqData.fromJson(Map<String, dynamic> json) =>
      AffilationReqData(
        isFounder: json["isFounder"],
        requests: json["requests"] == null
            ? []
            : List<Request>.from(
                json["requests"]!.map((x) => Request.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isFounder": isFounder,
        "requests": requests == null
            ? []
            : List<dynamic>.from(requests!.map((x) => x.toJson())),
      };
}

class Request {
  String? requestId;
  String? startUpId;
  UserDetails? userDetails;
  String? startDate;
  String? endDate;
  String? role;
  String? description;
  String? status;

  Request({
    this.requestId,
    this.startUpId,
    this.userDetails,
    this.startDate,
    this.endDate,
    this.role,
    this.description,
    this.status,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        requestId: json["requestId"],
        startUpId: json["startUpId"],
        userDetails: json["userDetails"] == null
            ? null
            : UserDetails.fromJson(json["userDetails"]),
        startDate: json["startDate"],
        endDate: json["endDate"],
        role: json["role"],
        description: json["description"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "requestId": requestId,
        "startUpId": startUpId,
        "userDetails": userDetails?.toJson(),
        "startDate": startDate,
        "endDate": endDate,
        "role": role,
        "description": description,
        "status": status,
      };
}

class UserDetails {
  String? id;
  String? firstName;
  String? lastName;
  String? profilePicture;
  String? email;

  UserDetails({
    this.id,
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.email,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePicture: json["profilePicture"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture,
      };
}
