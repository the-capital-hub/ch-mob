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
    Founder? founder;
    RevenueStatistics? revenueStatistics;
    CurrentFunding? currentFunding;
    List<InterestedInvestor>? interestedInvestors;
    PitchDeckDocuments? pitchDeckDocuments;
    List<PitchDeckDocuments>? documents;
    PitchRecordings? pitchRecordings;
    UpcomingPitchDay? upcomingPitchDay;
    List<AllocationDetail>? allocationDetails;
    FundingOverview? fundingOverview;
    List<String>? productImages;
    String? productDescription;
    List<Highlight>? highlights;

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
        this.founder,
        this.revenueStatistics,
        this.currentFunding,
        this.interestedInvestors,
        this.pitchDeckDocuments,
        this.documents,
        this.pitchRecordings,
        this.upcomingPitchDay,
        this.allocationDetails,
        this.fundingOverview,
        this.productImages,
        this.productDescription,
        this.highlights,
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
        founder: json["founder"] == null ? null : Founder.fromJson(json["founder"]),
        revenueStatistics: json["revenueStatistics"] == null ? null : RevenueStatistics.fromJson(json["revenueStatistics"]),
        currentFunding: json["currentFunding"] == null ? null : CurrentFunding.fromJson(json["currentFunding"]),
        interestedInvestors: json["interestedInvestors"] == null ? [] : List<InterestedInvestor>.from(json["interestedInvestors"]!.map((x) => InterestedInvestor.fromJson(x))),
        pitchDeckDocuments: json["pitchDeckDocuments"] == null ? null : PitchDeckDocuments.fromJson(json["pitchDeckDocuments"]),
        documents: json["documents"] == null ? [] : List<PitchDeckDocuments>.from(json["documents"]!.map((x) => PitchDeckDocuments.fromJson(x))),
        pitchRecordings: json["pitchRecordings"] == null ? null : PitchRecordings.fromJson(json["pitchRecordings"]),
        upcomingPitchDay: json["upcomingPitchDay"] == null ? null : UpcomingPitchDay.fromJson(json["upcomingPitchDay"]),
        allocationDetails: json["allocationDetails"] == null ? [] : List<AllocationDetail>.from(json["allocationDetails"]!.map((x) => AllocationDetail.fromJson(x))),
        fundingOverview: json["fundingOverview"] == null ? null : FundingOverview.fromJson(json["fundingOverview"]),
        productImages: json["productImages"] == null ? [] : List<String>.from(json["productImages"]!.map((x) => x)),
        productDescription: json["productDescription"],
        highlights: json["highlights"] == null ? [] : List<Highlight>.from(json["highlights"]!.map((x) => Highlight.fromJson(x))),
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
        "founder": founder?.toJson(),
        "revenueStatistics": revenueStatistics?.toJson(),
        "currentFunding": currentFunding?.toJson(),
        "interestedInvestors": interestedInvestors == null ? [] : List<dynamic>.from(interestedInvestors!.map((x) => x.toJson())),
        "pitchDeckDocuments": pitchDeckDocuments?.toJson(),
        "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x.toJson())),
        "pitchRecordings": pitchRecordings?.toJson(),
        "upcomingPitchDay": upcomingPitchDay?.toJson(),
        "allocationDetails": allocationDetails == null ? [] : List<dynamic>.from(allocationDetails!.map((x) => x.toJson())),
        "fundingOverview": fundingOverview?.toJson(),
        "productImages": productImages == null ? [] : List<dynamic>.from(productImages!.map((x) => x)),
        "productDescription": productDescription,
        "highlights": highlights == null ? [] : List<dynamic>.from(highlights!.map((x) => x.toJson())),
    };
}

class AllocationDetail {
    String? id;
    String? name;
    int? percentage;

    AllocationDetail({
        this.id,
        this.name,
        this.percentage,
    });

    factory AllocationDetail.fromJson(Map<String, dynamic> json) => AllocationDetail(
        id: json["_id"],
        name: json["name"],
        percentage: json["percentage"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "percentage": percentage,
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

class PitchDeckDocuments {
    String? id;
    String? fileName;
    String? folderName;
    String? fileUrl;
    String? thumbnail;

    PitchDeckDocuments({
        this.id,
        this.fileName,
        this.folderName,
        this.fileUrl,
        this.thumbnail,
    });

    factory PitchDeckDocuments.fromJson(Map<String, dynamic> json) => PitchDeckDocuments(
        id: json["_id"],
        fileName: json["fileName"],
        folderName: json["folderName"],
        fileUrl: json["fileUrl"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fileName": fileName,
        "folderName": folderName,
        "fileUrl": fileUrl,
        "thumbnail": thumbnail,
    };
}

class Founder {
    String? id;
    String? firstName;
    String? lastName;
    String? linkedin;
    String? profilePicture;
    String? designation;
    String? bio;
    String? userName;

    Founder({
        this.id,
        this.firstName,
        this.lastName,
        this.linkedin,
        this.profilePicture,
        this.designation,
        this.bio,
        this.userName,
    });

    factory Founder.fromJson(Map<String, dynamic> json) => Founder(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        linkedin: json["linkedin"],
        profilePicture: json["profilePicture"],
        designation: json["designation"],
        bio: json["bio"],
        userName: json["userName"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "linkedin": linkedin,
        "profilePicture": profilePicture,
        "designation": designation,
        "bio": bio,
        "userName": userName,
    };
}

class FundingOverview {
    int? fundingAsk;
    int? proposedFunding;
    int? raisedFunds;

    FundingOverview({
        this.fundingAsk,
        this.proposedFunding,
        this.raisedFunds,
    });

    factory FundingOverview.fromJson(Map<String, dynamic> json) => FundingOverview(
        fundingAsk: json["fundingAsk"],
        proposedFunding: json["proposedFunding"],
        raisedFunds: json["raisedFunds"],
    );

    Map<String, dynamic> toJson() => {
        "fundingAsk": fundingAsk,
        "proposedFunding": proposedFunding,
        "raisedFunds": raisedFunds,
    };
}

class Highlight {
    String? key;
    String? value;
    String? icon;
    String? id;

    Highlight({
        this.key,
        this.value,
        this.icon,
        this.id,
    });

    factory Highlight.fromJson(Map<String, dynamic> json) => Highlight(
        key: json["key"],
        value: json["value"],
        icon: json["icon"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
        "icon": icon,
        "_id": id,
    };
}

class InterestedInvestor {
    String? investorId;
    String? firstName;
    String? lastName;
    String? designation;
    String? profilePicture;
    String? proposedInvestment;

    InterestedInvestor({
        this.investorId,
        this.firstName,
        this.lastName,
        this.designation,
        this.profilePicture,
        this.proposedInvestment,
    });

    factory InterestedInvestor.fromJson(Map<String, dynamic> json) => InterestedInvestor(
        investorId: json["investorId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        designation: json["designation"],
        profilePicture: json["profilePicture"],
        proposedInvestment: json["proposedInvestment"],
    );

    Map<String, dynamic> toJson() => {
        "investorId": investorId,
        "firstName": firstName,
        "lastName": lastName,
        "designation": designation,
        "profilePicture": profilePicture,
        "proposedInvestment": proposedInvestment,
    };
}

class PitchRecordings {
    String? id;
    String? fileName;
    String? folderName;
    String? fileUrl;
    String? videoUrl;
    String? userMessage;

    PitchRecordings({
        this.id,
        this.fileName,
        this.folderName,
        this.fileUrl,
        this.videoUrl,
        this.userMessage,
    });

    factory PitchRecordings.fromJson(Map<String, dynamic> json) => PitchRecordings(
        id: json["_id"],
        fileName: json["fileName"],
        folderName: json["folderName"],
        fileUrl: json["fileUrl"],
        videoUrl: json["videoUrl"],
        userMessage: json["userMessage"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fileName": fileName,
        "folderName": folderName,
        "fileUrl": fileUrl,
        "videoUrl": videoUrl,
        "userMessage": userMessage,
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

class UpcomingPitchDay {
    String? id;
    String? title;
    String? description;
    String? date;
    String? startTime;
    String? endTime;
    String? link;
    String? image;

    UpcomingPitchDay({
        this.id,
        this.title,
        this.description,
        this.date,
        this.startTime,
        this.endTime,
        this.link,
        this.image,
    });

    factory UpcomingPitchDay.fromJson(Map<String, dynamic> json) => UpcomingPitchDay(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        link: json["link"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "link": link,
        "image": image,
    };
}
