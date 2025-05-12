// To parse this JSON data, do
//
//     final onelinkRequestModel = onelinkRequestModelFromJson(jsonString);

import 'dart:convert';

OnelinkRequestModel onelinkRequestModelFromJson(String str) => OnelinkRequestModel.fromJson(json.decode(str));

String onelinkRequestModelToJson(OnelinkRequestModel data) => json.encode(data.toJson());

class OnelinkRequestModel {
    bool? status;
    String? message;
    OnelinkReqData? data;

    OnelinkRequestModel({
        this.status,
        this.message,
        this.data,
    });

    factory OnelinkRequestModel.fromJson(Map<String, dynamic> json) => OnelinkRequestModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : OnelinkReqData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class OnelinkReqData {
    bool? isFounder;
    List<Request>? requests;

    OnelinkReqData({
        this.isFounder,
        this.requests,
    });

    factory OnelinkReqData.fromJson(Map<String, dynamic> json) => OnelinkReqData(
        isFounder: json["isFounder"],
        requests: json["requests"] == null ? [] : List<Request>.from(json["requests"]!.map((x) => Request.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "isFounder": isFounder,
        "requests": requests == null ? [] : List<dynamic>.from(requests!.map((x) => x.toJson())),
    };
}

class Request {
    String? requestId;
    String? startUpId;
    User? user;
    String? status;

    Request({
        this.requestId,
        this.startUpId,
        this.user,
        this.status,
    });

    factory Request.fromJson(Map<String, dynamic> json) => Request(
        requestId: json["requestId"],
        startUpId: json["startUpId"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "requestId": requestId,
        "startUpId": startUpId,
        "user": user?.toJson(),
        "status": status,
    };
}

class User {
    String? id;
    String? firstName;
    String? lastName;
    String? profilePicture;
    String? designation;

    User({
        this.id,
        this.firstName,
        this.lastName,
        this.profilePicture,
        this.designation,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePicture: json["profilePicture"],
        designation: json["designation"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture,
        "designation": designation,
    };
}
