// To parse this JSON data, do
//
//     final spotlightRequestModel = spotlightRequestModelFromJson(jsonString);


// To parse this JSON data, do
//
//     final spotlightRequestModel = spotlightRequestModelFromJson(jsonString);

import 'dart:convert';

SpotlightRequestModel spotlightRequestModelFromJson(String str) => SpotlightRequestModel.fromJson(json.decode(str));

String spotlightRequestModelToJson(SpotlightRequestModel data) => json.encode(data.toJson());

class SpotlightRequestModel {
    bool? status;
    String? message;
    List<RequestData>? data;

    SpotlightRequestModel({
        this.status,
        this.message,
        this.data,
    });

    factory SpotlightRequestModel.fromJson(Map<String, dynamic> json) => SpotlightRequestModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<RequestData>.from(json["data"]!.map((x) => RequestData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class RequestData {
    String? id;
    String? productId;
    String? title;
    String? logo;
    String? tagline;
    List<String>? tags;
    String? remarkText;
    String? createdAt;
    String? pitchDeckDocumentUrl;
    bool? requestedFromAnalyst;
    Requester? requester;
    List<KycDocument>? kycDocuments;
    List<SubmissionHistory>? submissionHistory;

    RequestData({
        this.id,
        this.productId,
        this.title,
        this.logo,
        this.tagline,
        this.tags,
        this.remarkText,
        this.createdAt,
        this.pitchDeckDocumentUrl,
        this.requestedFromAnalyst,
        this.requester,
        this.kycDocuments,
        this.submissionHistory,
    });

    factory RequestData.fromJson(Map<String, dynamic> json) => RequestData(
        id: json["id"],
        productId: json["productId"],
        title: json["title"],
        logo: json["logo"],
        tagline: json["tagline"],
        tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
        remarkText: json["remarkText"],
        createdAt: json["createdAt"],
        pitchDeckDocumentUrl: json["pitchDeckDocumentUrl"],
        requestedFromAnalyst: json["requestedFromAnalyst"],
        requester: json["requester"] == null ? null : Requester.fromJson(json["requester"]),
        kycDocuments: json["kycDocuments"] == null ? [] : List<KycDocument>.from(json["kycDocuments"]!.map((x) => KycDocument.fromJson(x))),
        submissionHistory: json["submissionHistory"] == null ? [] : List<SubmissionHistory>.from(json["submissionHistory"]!.map((x) => SubmissionHistory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "title": title,
        "logo": logo,
        "tagline": tagline,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "remarkText": remarkText,
        "createdAt": createdAt,
        "pitchDeckDocumentUrl": pitchDeckDocumentUrl,
        "requestedFromAnalyst": requestedFromAnalyst,
        "requester": requester?.toJson(),
        "kycDocuments": kycDocuments == null ? [] : List<dynamic>.from(kycDocuments!.map((x) => x.toJson())),
        "submissionHistory": submissionHistory == null ? [] : List<dynamic>.from(submissionHistory!.map((x) => x.toJson())),
    };
}

class KycDocument {
    String? fileName;
    String? fileUrl;

    KycDocument({
        this.fileName,
        this.fileUrl,
    });

    factory KycDocument.fromJson(Map<String, dynamic> json) => KycDocument(
        fileName: json["fileName"],
        fileUrl: json["fileUrl"],
    );

    Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "fileUrl": fileUrl,
    };
}

class Requester {
    String? name;
    String? email;
    String? phoneNumber;

    Requester({
        this.name,
        this.email,
        this.phoneNumber,
    });

    factory Requester.fromJson(Map<String, dynamic> json) => Requester(
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
    };
}

class SubmissionHistory {
    String? date;
    String? status;

    SubmissionHistory({
        this.date,
        this.status,
    });

    factory SubmissionHistory.fromJson(Map<String, dynamic> json) => SubmissionHistory(
        date: json["date"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "status": status,
    };
}

