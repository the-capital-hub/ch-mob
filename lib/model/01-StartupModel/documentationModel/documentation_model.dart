// To parse this JSON data, do
//
//     final documentationModel = documentationModelFromJson(jsonString);

import 'dart:convert';

DocumentationModel documentationModelFromJson(String str) =>
    DocumentationModel.fromJson(json.decode(str));

String documentationModelToJson(DocumentationModel data) =>
    json.encode(data.toJson());

class DocumentationModel {
  bool? status;
  String? message;
  List<DocData>? data;

  DocumentationModel({
    this.status,
    this.message,
    this.data,
  });

  factory DocumentationModel.fromJson(Map<String, dynamic> json) =>
      DocumentationModel(
        status: json["status"],
        message: json["message"],
        data: List<DocData>.from(json["data"].map((x) => DocData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DocData {
  String? id;
  String? userId;
  String? fileName;
  String? folderName;
  String? fileUrl;
  String? extension;

  DocData({
    this.id,
    this.userId,
    this.fileName,
    this.folderName,
    this.fileUrl,
    this.extension,
  });

  factory DocData.fromJson(Map<String, dynamic> json) => DocData(
        id: json["_id"],
        userId: json["userId"],
        fileName: json["fileName"],
        folderName: json["folderName"],
        fileUrl: json["fileUrl"],
        extension: json["extension"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "fileName": fileName,
        "folderName": folderName,
        "fileUrl": fileUrl,
        "extension": extension,
      };
}
