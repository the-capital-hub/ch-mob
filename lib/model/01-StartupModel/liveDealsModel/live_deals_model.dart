// To parse this JSON data, do
//
//     final liveDealsModel = liveDealsModelFromJson(jsonString);

import 'dart:convert';

LiveDealsModel liveDealsModelFromJson(String str) => LiveDealsModel.fromJson(json.decode(str));

String liveDealsModelToJson(LiveDealsModel data) => json.encode(data.toJson());

class LiveDealsModel {
    bool? status;
    String? message;
    List<LiveDealData>? data;

    LiveDealsModel({
        this.status,
        this.message,
        this.data,
    });

    factory LiveDealsModel.fromJson(Map<String, dynamic> json) => LiveDealsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<LiveDealData>.from(json["data"]!.map((x) => LiveDealData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class LiveDealData {
    String? liveDealId;
    String? startupId;
    List<SocialLink>? socialLinks;
    String? company;
    String? description;
    String? sector;
    String? location;
    String? logo;
    int? noOfEmployees;
    String? myInterest;
    String? oneLinkRequestStatus;
    String? founderId;
    RevenueStatistics? revenueStatistics;
    CurrentFunding? currentFunding;
    List<InterestedInvestor>? interestedInvestors;

    LiveDealData({
        this.liveDealId,
        this.startupId,
        this.socialLinks,
        this.company,
        this.description,
        this.sector,
        this.location,
        this.logo,
        this.noOfEmployees,
        this.myInterest,
        this.oneLinkRequestStatus,
        this.founderId,
        this.revenueStatistics,
        this.currentFunding,
        this.interestedInvestors,
    });

    factory LiveDealData.fromJson(Map<String, dynamic> json) => LiveDealData(
        liveDealId: json["liveDealId"],
        startupId: json["startupId"],
        socialLinks: json["socialLinks"] == null ? [] : List<SocialLink>.from(json["socialLinks"]!.map((x) => SocialLink.fromJson(x))),
        company: json["company"],
        description: json["description"],
        sector: json["sector"],
        location: json["location"],
        logo: json["logo"],
        noOfEmployees: json["noOfEmployees"],
        myInterest: json["myInterest"],
        oneLinkRequestStatus: json["oneLinkRequestStatus"],
        founderId: json["founderId"],
        revenueStatistics: json["revenueStatistics"] == null ? null : RevenueStatistics.fromJson(json["revenueStatistics"]),
        currentFunding: json["currentFunding"] == null ? null : CurrentFunding.fromJson(json["currentFunding"]),
        interestedInvestors: json["interestedInvestors"] == null ? [] : List<InterestedInvestor>.from(json["interestedInvestors"]!.map((x) => InterestedInvestor.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "liveDealId": liveDealId,
        "startupId": startupId,
        "socialLinks": socialLinks == null ? [] : List<dynamic>.from(socialLinks!.map((x) => x.toJson())),
        "company": company,
        "description": description,
        "sector": sector,
        "location": location,
        "logo": logo,
        "noOfEmployees": noOfEmployees,
        "myInterest": myInterest,
        "oneLinkRequestStatus": oneLinkRequestStatus,
        "founderId": founderId,
        "revenueStatistics": revenueStatistics?.toJson(),
        "currentFunding": currentFunding?.toJson(),
        "interestedInvestors": interestedInvestors == null ? [] : List<dynamic>.from(interestedInvestors!.map((x) => x.toJson())),
    };
}

class CurrentFunding {
    String? maximumTicketsSize;
    String? minimumTicketsSize;
    String? seedRound;

    CurrentFunding({
        this.maximumTicketsSize,
        this.minimumTicketsSize,
        this.seedRound,
    });

    factory CurrentFunding.fromJson(Map<String, dynamic> json) => CurrentFunding(
        maximumTicketsSize: json["maximumTicketsSize"],
        minimumTicketsSize: json["minimumTicketsSize"],
        seedRound: json["seedRound"],
    );

    Map<String, dynamic> toJson() => {
        "maximumTicketsSize": maximumTicketsSize,
        "minimumTicketsSize": minimumTicketsSize,
        "seedRound": seedRound,
    };
}

class InterestedInvestor {
    String? id;
    String? firstName;
    String? lastName;
    String? profilePicture;
    String? designation;

    InterestedInvestor({
        this.id,
        this.firstName,
        this.lastName,
        this.profilePicture,
        this.designation,
    });

    factory InterestedInvestor.fromJson(Map<String, dynamic> json) => InterestedInvestor(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePicture: json["profilePicture"],
        designation: json["designation"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture,
        "designation": designation,
    };
}

class RevenueStatistics {
    String? seedRound;
    String? maximumTicketsSize;

    RevenueStatistics({
        this.seedRound,
        this.maximumTicketsSize,
    });

    factory RevenueStatistics.fromJson(Map<String, dynamic> json) => RevenueStatistics(
        seedRound: json["seedRound"],
        maximumTicketsSize: json["maximumTicketsSize"],
    );

    Map<String, dynamic> toJson() => {
        "seedRound": seedRound,
        "maximumTicketsSize": maximumTicketsSize,
    };
}

class SocialLink {
    String? name;
    String? link;
    String? logo;

    SocialLink({
        this.name,
        this.link,
        this.logo,
    });

    factory SocialLink.fromJson(Map<String, dynamic> json) => SocialLink(
        name: json["name"],
        link: json["link"],
        logo: json["logo"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "link": link,
        "logo": logo,
    };
}
