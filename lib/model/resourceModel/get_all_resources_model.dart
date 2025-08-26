// To parse this JSON data, do
//
//     final getAllResourcesModel = getAllResourcesModelFromJson(jsonString);

import 'dart:convert';
import 'dart:typed_data';

GetAllResourcesModel getAllResourcesModelFromJson(String str) => GetAllResourcesModel.fromJson(json.decode(str));

String getAllResourcesModelToJson(GetAllResourcesModel data) => json.encode(data.toJson());

class GetAllResourcesModel {
    bool? status;
    String? message;
    AllResources? data;

    GetAllResourcesModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetAllResourcesModel.fromJson(Map<String, dynamic> json) => GetAllResourcesModel(
        status: json["status"],
        message: json["message"],
        data: AllResources.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
    };
}

class AllResources {
    bool? isSubscribed;
    List<Resource>? resources;

    AllResources({
        this.isSubscribed,
        this.resources,
    });

    factory AllResources.fromJson(Map<String, dynamic> json) => AllResources(
        isSubscribed: json["isSubscribed"],
        resources: List<Resource>.from(json["resources"].map((x) => Resource.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "isSubscribed": isSubscribed,
        "resources": List<dynamic>.from(resources!.map((x) => x.toJson())),
    };
}

class Resource {
    String? resourceId;
    String? title;
    String? logoUrl;

    Resource({
        this.resourceId,
        this.title,
        this.logoUrl,
    });

    factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        resourceId: json["resourceId"],
        title: json["title"],
        logoUrl: json["logoUrl"],
    );

    Map<String, dynamic> toJson() => {
        "resourceId": resourceId,
        "title": title,
        "logoUrl": logoUrl,
    };
}
