// To parse this JSON data, do
//
//     final campaignListViewModel = campaignListViewModelFromJson(jsonString);

import 'dart:convert';

CampaignListViewModel campaignListViewModelFromJson(String str) => CampaignListViewModel.fromJson(json.decode(str));

String campaignListViewModelToJson(CampaignListViewModel data) => json.encode(data.toJson());

class CampaignListViewModel {
    bool? status;
    String? message;
    ViewCampaignData? data;

    CampaignListViewModel({
        this.status,
        this.message,
        this.data,
    });

    factory CampaignListViewModel.fromJson(Map<String, dynamic> json) => CampaignListViewModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : ViewCampaignData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class ViewCampaignData {
    String? listId;
    String? listName;
    int? peopleCount;
    String? description;
    String? createdBy;
    List<Investor>? investors;

    ViewCampaignData({
        this.listId,
        this.listName,
        this.peopleCount,
        this.description,
        this.createdBy,
        this.investors,
    });

    factory ViewCampaignData.fromJson(Map<String, dynamic> json) => ViewCampaignData(
        listId: json["list_id"],
        listName: json["list_name"],
        peopleCount: json["people_count"],
        description: json["description"],
        createdBy: json["created_by"],
        investors: json["investors"] == null ? [] : List<Investor>.from(json["investors"]!.map((x) => Investor.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "list_id": listId,
        "list_name": listName,
        "people_count": peopleCount,
        "description": description,
        "created_by": createdBy,
        "investors": investors == null ? [] : List<dynamic>.from(investors!.map((x) => x.toJson())),
    };
}

class Investor {
    String? investorId;
    String? investorName;
    String? investorLocation;
    String? investorCompany;
    String? investorProfilePicture;

    Investor({
        this.investorId,
        this.investorName,
        this.investorLocation,
        this.investorCompany,
        this.investorProfilePicture,
    });

    factory Investor.fromJson(Map<String, dynamic> json) => Investor(
        investorId: json["investor_id"],
        investorName: json["investor_name"],
        investorLocation: json["investor_location"],
        investorCompany: json["investor_company"],
        investorProfilePicture: json["investor_profile_picture"],
    );

    Map<String, dynamic> toJson() => {
        "investor_id": investorId,
        "investor_name": investorName,
        "investor_location": investorLocation,
        "investor_company": investorCompany,
        "investor_profile_picture": investorProfilePicture,
    };
}
