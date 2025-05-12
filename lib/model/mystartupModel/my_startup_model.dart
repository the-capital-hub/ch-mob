
import 'dart:convert';

MyStartupModel myStartupModelFromJson(String str) => MyStartupModel.fromJson(json.decode(str));

String myStartupModelToJson(MyStartupModel data) => json.encode(data.toJson());

class MyStartupModel {
    bool? status;
    String? message;
    StartupData? data;

    MyStartupModel({
        this.status,
        this.message,
        this.data,
    });

    factory MyStartupModel.fromJson(Map<String, dynamic> json) => MyStartupModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : StartupData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class StartupData {
    List<MyInvestment>? myInvestments;
    List<MyInterest>? myInterests;
    List<MyInterest>? pastInvestments;

    StartupData({
        this.myInvestments,
        this.myInterests,
        this.pastInvestments,
    });

    factory StartupData.fromJson(Map<String, dynamic> json) => StartupData(
        myInvestments: json["myInvestments"] == null ? [] : List<MyInvestment>.from(json["myInvestments"]!.map((x) => MyInvestment.fromJson(x))),
        myInterests: json["myInterests"] == null ? [] : List<MyInterest>.from(json["myInterests"]!.map((x) => MyInterest.fromJson(x))),
        pastInvestments: json["pastInvestments"] == null ? [] : List<MyInterest>.from(json["pastInvestments"]!.map((x) => MyInterest.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "myInvestments": myInvestments == null ? [] : List<dynamic>.from(myInvestments!.map((x) => x.toJson())),
        "myInterests": myInterests == null ? [] : List<dynamic>.from(myInterests!.map((x) => x.toJson())),
        "pastInvestments": pastInvestments == null ? [] : List<dynamic>.from(pastInvestments!.map((x) => x.toJson())),
    };
}

class MyInterest {
    String? companyId;
    String? logo;
    String? name;
    String? description;
    String? investmentId;

    MyInterest({
        this.companyId,
        this.logo,
        this.name,
        this.description,
        this.investmentId,
    });

    factory MyInterest.fromJson(Map<String, dynamic> json) => MyInterest(
        companyId: json["companyId"],
        logo: json["logo"],
        name: json["name"],
        description: json["description"],
        investmentId: json["investmentId"],
    );

    Map<String, dynamic> toJson() => {
        "companyId": companyId,
        "logo": logo,
        "name": name,
        "description": description,
        "investmentId": investmentId,
    };
}

class MyInvestment {
    String? name;
    String? description;
    String? logo;
    String? investedEquity;
    String? id;

    MyInvestment({
        this.name,
        this.description,
        this.logo,
        this.investedEquity,
        this.id,
    });

    factory MyInvestment.fromJson(Map<String, dynamic> json) => MyInvestment(
        name: json["name"],
        description: json["description"],
        logo: json["logo"],
        investedEquity: json["investedEquity"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "logo": logo,
        "investedEquity": investedEquity,
        "_id": id,
    };
}
