// To parse this JSON data, do
//
//     final getCampaignListModel = getCampaignListModelFromJson(jsonString);

import 'dart:convert';

GetCampaignListModel getCampaignListModelFromJson(String str) => GetCampaignListModel.fromJson(json.decode(str));

String getCampaignListModelToJson(GetCampaignListModel data) => json.encode(data.toJson());

class GetCampaignListModel {
    List<CampaignList>? data;
    bool? status;
    String? message;

    GetCampaignListModel({
        this.data,
        this.status,
        this.message,
    });

    factory GetCampaignListModel.fromJson(Map<String, dynamic> json) => GetCampaignListModel(
        data: json["data"] == null ? [] : List<CampaignList>.from(json["data"]!.map((x) => CampaignList.fromJson(x))),
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
        "message": message,
    };
}

class CampaignList {
    String? listId;
    String? listName;
    int? peopleCount;

    CampaignList({
        this.listId,
        this.listName,
        this.peopleCount,
    });

    factory CampaignList.fromJson(Map<String, dynamic> json) => CampaignList(
        listId: json["list_id"],
        listName: json["list_name"],
        peopleCount: json["people_count"],
    );

    Map<String, dynamic> toJson() => {
        "list_id": listId,
        "list_name": listName,
        "people_count": peopleCount,
    };
}
