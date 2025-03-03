// To parse this JSON data, do
//
//     final exploreInvestorModel = exploreInvestorModelFromJson(jsonString);

import 'dart:convert';

ExploreInvestorModel exploreInvestorModelFromJson(String str) => ExploreInvestorModel.fromJson(json.decode(str));

String exploreInvestorModelToJson(ExploreInvestorModel data) => json.encode(data.toJson());

class ExploreInvestorModel {
    bool? status;
    String? message;
    List<InvestorExplore>? data;

    ExploreInvestorModel({
        this.status,
        this.message,
        this.data,
    });

    factory ExploreInvestorModel.fromJson(Map<String, dynamic> json) => ExploreInvestorModel(
        status: json["status"],
        message: json["message"],
        data: List<InvestorExplore>.from(json["data"].map((x) => InvestorExplore.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class InvestorExplore {
    String? name;
    String? investorId;
    String? location;
    String? designation;
    String? profilePicture;
    String? bio;
    String? companyName;
    String? companyLogo;
    String? linkedin;
    List<StartupsInvested>? startupsInvested;
    String? recentInvestment;
    String? avgRecentInvestment;
    String? avgAge;

    InvestorExplore({
        this.name,
        this.investorId,
        this.location,
        this.designation,
        this.profilePicture,
        this.bio,
        this.companyName,
        this.companyLogo,
        this.linkedin,
        this.startupsInvested,
        this.recentInvestment,
        this.avgRecentInvestment,
        this.avgAge,
    });

    factory InvestorExplore.fromJson(Map<String, dynamic> json) => InvestorExplore(
        name: json["name"],
        investorId: json["investorId"],
        location: json["location"],
        designation: json["designation"],
        profilePicture: json["profilePicture"],
        bio: json["bio"],
        companyName: json["companyName"],
        companyLogo: json["companyLogo"],
        linkedin: json["linkedin"],
        startupsInvested: List<StartupsInvested>.from(json["startupsInvested"].map((x) => StartupsInvested.fromJson(x))),
        recentInvestment: json["recentInvestment"],
        avgRecentInvestment: json["avgRecentInvestment"],
        avgAge: json["avgAge"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "location": location,
        "designation": designation,
        "profilePicture": profilePicture,
        "bio": bio,
        "companyName": companyName,
        "companyLogo": companyLogo,
        "linkedin": linkedin,
        "startupsInvested": List<dynamic>.from(startupsInvested!.map((x) => x.toJson())),
        "recentInvestment": recentInvestment,
        "avgRecentInvestment": avgRecentInvestment,
        "avgAge": avgAge,
    };
}

class StartupsInvested {
    String? id;
    String? logo;
    String? name;

    StartupsInvested({
        this.id,
        this.logo,
        this.name,
    });

    factory StartupsInvested.fromJson(Map<String, dynamic> json) => StartupsInvested(
        id: json["_id"],
        logo: json["logo"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "logo": logo,
        "name": name,
    };
}
