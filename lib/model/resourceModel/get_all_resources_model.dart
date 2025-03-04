// To parse this JSON data, do
//
//     final getAllResourcesModel = getAllResourcesModelFromJson(jsonString);

import 'dart:convert';

GetAllResourcesModel getAllResourcesModelFromJson(String str) => GetAllResourcesModel.fromJson(json.decode(str));

String getAllResourcesModelToJson(GetAllResourcesModel data) => json.encode(data.toJson());

class GetAllResourcesModel {
    bool status;
    String message;
    AllResources data;

    GetAllResourcesModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetAllResourcesModel.fromJson(Map<String, dynamic> json) => GetAllResourcesModel(
        status: json["status"],
        message: json["message"],
        data: AllResources.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class AllResources {
    bool isSubscribed;
    List<Resource> resources;

    AllResources({
        required this.isSubscribed,
        required this.resources,
    });

    factory AllResources.fromJson(Map<String, dynamic> json) => AllResources(
        isSubscribed: json["isSubscribed"],
        resources: List<Resource>.from(json["resources"].map((x) => Resource.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "isSubscribed": isSubscribed,
        "resources": List<dynamic>.from(resources.map((x) => x.toJson())),
    };
}

class Resource {
    String resourceId;
    String title;
    String logoUrl;

    Resource({
        required this.resourceId,
        required this.title,
        required this.logoUrl,
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
