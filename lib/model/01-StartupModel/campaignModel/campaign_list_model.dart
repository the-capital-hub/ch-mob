// To parse this JSON data, do
//
//     final allCampaignListModel = allCampaignListModelFromJson(jsonString);

import 'dart:convert';

AllCampaignListModel allCampaignListModelFromJson(String str) =>
    AllCampaignListModel.fromJson(json.decode(str));

String allCampaignListModelToJson(AllCampaignListModel data) =>
    json.encode(data.toJson());

class AllCampaignListModel {
  List<AllCampaignList>? data;
  bool? status;
  String? message;

  AllCampaignListModel({
    this.data,
    this.status,
    this.message,
  });

  factory AllCampaignListModel.fromJson(Map<String, dynamic> json) =>
      AllCampaignListModel(
        data: json["data"] == null
            ? []
            : List<AllCampaignList>.from(
                json["data"]!.map((x) => AllCampaignList.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class AllCampaignList {
  String? listId;
  String? listName;
  String? description;
  String? peopleCount;
  bool isSelected = false;
  bool? isMyList;
  String? createdBy;
  List<dynamic>? sharing;

  AllCampaignList({
    this.listId,
    this.description,
    this.listName,
    this.peopleCount,
    this.isMyList,
    this.createdBy,
    this.sharing,
  });

  factory AllCampaignList.fromJson(Map<String, dynamic> json) =>
      AllCampaignList(
        listId: json["list_id"],
        listName: json["list_name"],
        description: json["description"],
        peopleCount: json["people_count"].toString(),
        isMyList: json["is_my_list"],
        createdBy: json["created_by"],
        sharing: json["sharing"] == null
            ? []
            : List<dynamic>.from(json["sharing"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "list_id": listId,
        "list_name": listName,
        "people_count": peopleCount,
        "is_my_list": isMyList,
        "created_by": createdBy,
        "sharing":
            sharing == null ? [] : List<dynamic>.from(sharing!.map((x) => x)),
      };
}
