// To parse this JSON data, do
//
//     final fetchFolder = fetchFolderFromJson(jsonString);

import 'dart:convert';

FetchFolder fetchFolderFromJson(String str) => FetchFolder.fromJson(json.decode(str));

String fetchFolderToJson(FetchFolder data) => json.encode(data.toJson());

class FetchFolder {
    bool? status;
    String? message;
    List<FolderData>? data;

    FetchFolder({
        this.status,
        this.message,
        this.data,
    });

    factory FetchFolder.fromJson(Map<String, dynamic> json) => FetchFolder(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<FolderData>.from(json["data"]!.map((x) => FolderData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class FolderData {
    String? folderName;
    int? documentCount;

    FolderData({
        this.folderName,
        this.documentCount,
    });

    factory FolderData.fromJson(Map<String, dynamic> json) => FolderData(
        folderName: json["folderName"],
        documentCount: json["documentCount"],
    );

    Map<String, dynamic> toJson() => {
        "folderName": folderName,
        "documentCount": documentCount,
    };
}
