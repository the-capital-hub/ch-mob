// To parse this JSON data, do
//
//     final getAllResourcesByIdModel = getAllResourcesByIdModelFromJson(jsonString);

import 'dart:convert';

GetAllResourcesByIdModel getAllResourcesByIdModelFromJson(String str) => GetAllResourcesByIdModel.fromJson(json.decode(str));

String getAllResourcesByIdModelToJson(GetAllResourcesByIdModel data) => json.encode(data.toJson());

class GetAllResourcesByIdModel {
    bool? status;
    String? message;
    ResourceById? data;

    GetAllResourcesByIdModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetAllResourcesByIdModel.fromJson(Map<String, dynamic> json) => GetAllResourcesByIdModel(
        status: json["status"],
        message: json["message"],
        data: ResourceById.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
    };
}

class ResourceById {
    String? resourceId;
    String? title;
    String? logoUrl;
    String? description;
    List<FileElement>? files;

    ResourceById({
        this.resourceId,
        this.title,
        this.logoUrl,
        this.description,
        this.files,
    });

    factory ResourceById.fromJson(Map<String, dynamic> json) => ResourceById(
        resourceId: json["resourceId"],
        title: json["title"],
        logoUrl: json["logoUrl"],
        description: json["description"],
        files: List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resourceId": resourceId,
        "title": title,
        "logoUrl": logoUrl,
        "description": description,
        "files": List<dynamic>.from(files!.map((x) => x.toJson())),
    };
}

class FileElement {
    String? name;
    String? url;
    String? extension;
    String? id;

    FileElement({
        this.name,
        this.url,
        this.extension,
        this.id,
    });

    factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        name: json["name"],
        url: json["url"],
        extension: json["extension"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "extension": extension,
        "_id": id,
    };
}
