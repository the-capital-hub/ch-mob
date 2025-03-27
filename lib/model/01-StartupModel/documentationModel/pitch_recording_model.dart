// To parse this JSON data, do
//
//     final proceedTemplateModel = proceedTemplateModelFromJson(jsonString);

import 'dart:convert';

PitchRecordModel proceedTemplateModelFromJson(String str) => PitchRecordModel.fromJson(json.decode(str));

String proceedTemplateModelToJson(PitchRecordModel data) => json.encode(data.toJson());

class PitchRecordModel {
    bool? status;
    String? message;
    List<PitchRecord>? data;

    PitchRecordModel({
        this.status,
        this.message,
        this.data,
    });

    factory PitchRecordModel.fromJson(Map<String, dynamic> json) => PitchRecordModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<PitchRecord>.from(json["data"]!.map((x) => PitchRecord.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class PitchRecord {
    String? id;
    String? userId;
    String? fileName;
    String? folderName;
    String? fileUrl;
    String? extension;
    String? videoUrl;

    PitchRecord({
        this.id,
        this.userId,
        this.fileName,
        this.folderName,
        this.fileUrl,
        this.extension,
        this.videoUrl,
    });

    factory PitchRecord.fromJson(Map<String, dynamic> json) => PitchRecord(
        id: json["_id"],
        userId: json["userId"],
        fileName: json["fileName"],
        folderName: json["folderName"],
        fileUrl: json["fileUrl"],
        extension: json["extension"],
        videoUrl: json["videoUrl"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "fileName": fileName,
        "folderName": folderName,
        "fileUrl": fileUrl,
        "extension": extension,
        "videoUrl": videoUrl,
    };
}
