// To parse this JSON data, do
//
//     final outreachViewModel = outreachViewModelFromJson(jsonString);

import 'dart:convert';

OutreachViewModel outreachViewModelFromJson(String str) =>
    OutreachViewModel.fromJson(json.decode(str));

String outreachViewModelToJson(OutreachViewModel data) =>
    json.encode(data.toJson());

class OutreachViewModel {
  bool? status;
  String? message;
  OutreachView? data;

  OutreachViewModel({
    this.status,
    this.message,
    this.data,
  });

  factory OutreachViewModel.fromJson(Map<String, dynamic> json) =>
      OutreachViewModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : OutreachView.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class OutreachView {
  String? campaignId;
  String? campaignName;
  String? status;
  String? campaignCreatedAt;
  String? campaignSentAt;
  String? campaignScheduledAt;
  Overview? overview;
  Recipients? recipients;

  EmailContent? emailContent;

  OutreachView({
    this.campaignId,
    this.campaignName,
    this.status,
    this.campaignCreatedAt,
    this.campaignSentAt,
    this.campaignScheduledAt,
    this.overview,
    this.recipients,
    this.emailContent,
  });

  factory OutreachView.fromJson(Map<String, dynamic> json) => OutreachView(
        campaignId: json["campaignId"],
        campaignName: json["campaignName"],
        status: json["status"],
        campaignCreatedAt: json["campaignCreatedAt"],
        campaignSentAt: json["campaignSentAt"],
        campaignScheduledAt: json["campaignScheduledAt"],
        overview: json["overview"] == null
            ? null
            : Overview.fromJson(json["overview"]),
        recipients: json["recipients"] == null
            ? null
            : Recipients.fromJson(json["recipients"]),
        emailContent: json["emailContent"] == null
            ? null
            : EmailContent.fromJson(json["emailContent"]),
      );

  Map<String, dynamic> toJson() => {
        "campaignId": campaignId,
        "campaignName": campaignName,
        "status": status,
        "campaignCreatedAt": campaignCreatedAt,
        "campaignSentAt": campaignSentAt,
        "campaignScheduledAt": campaignScheduledAt,
        "overview": overview?.toJson(),
        "recipients": recipients?.toJson(),
        "emailContent": emailContent?.toJson(),
      };
}

class EmailContent {
  String? subject;
  String? body;

  EmailContent({
    this.subject,
    this.body,
  });

  factory EmailContent.fromJson(Map<String, dynamic> json) => EmailContent(
        subject: json["subject"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "subject": subject,
        "body": body,
      };
}

class Overview {
  String? sent;
  String? opened;
  String? clicked;
  String? replied;
  String? bounced;
  List<String>? investorLists;

  Overview({
    this.sent,
    this.opened,
    this.clicked,
    this.replied,
    this.bounced,
    this.investorLists,
  });

  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
        sent: json["sent"],
        opened: json["opened"],
        clicked: json["clicked"],
        replied: json["replied"],
        bounced: json["bounced"],
        investorLists: json["investorLists"] == null
            ? []
            : List<String>.from(json["investorLists"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "sent": sent,
        "opened": opened,
        "clicked": clicked,
        "replied": replied,
        "bounced": bounced,
        "investorLists": investorLists == null
            ? []
            : List<dynamic>.from(investorLists!.map((x) => x)),
      };
}

class Recipients {
  String? total;
  List<Investor>? investors;
  List<VCs>? vcs;

  Recipients({this.total, this.investors, this.vcs});

  factory Recipients.fromJson(Map<String, dynamic> json) => Recipients(
        total: json["total"],
        investors: json["investors"] == null
            ? []
            : List<Investor>.from(
                json["investors"]!.map((x) => Investor.fromJson(x))),
        vcs: json["vcs"] == null
            ? []
            : List<VCs>.from(
                json["vcs"]!.map((x) => VCs.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "investors": investors == null
            ? []
            : List<dynamic>.from(investors!.map((x) => x.toJson())),
      };
}

class Investor {
  String? investorId;
  String? email;
  String? firstName;
  String? lastName;
  String? status;
  String? emailOpened;
  String? emailClicked;
  String? emailReplied;
  String? emailBounced;

  Investor({
    this.investorId,
    this.email,
    this.firstName,
    this.lastName,
    this.status,
    this.emailOpened,
    this.emailClicked,
    this.emailReplied,
    this.emailBounced,
  });

  factory Investor.fromJson(Map<String, dynamic> json) => Investor(
        investorId: json["investorId"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        status: json["status"],
        emailOpened: json["emailOpened"],
        emailClicked: json["emailClicked"],
        emailReplied: json["emailReplied"],
        emailBounced: json["emailBounced"],
      );

  Map<String, dynamic> toJson() => {
        "investorId": investorId,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "status": status,
        "emailOpened": emailOpened,
        "emailClicked": emailClicked,
        "emailReplied": emailReplied,
        "emailBounced": emailBounced,
      };
}

class VCs {
  String? vcId;
  String? email;
  String? name;
  String? status;
  String? emailOpened;
  String? emailClicked;
  String? emailReplied;
  String? emailBounced;

  VCs({
    this.vcId,
    this.email,
    this.name,
    this.status,
    this.emailOpened,
    this.emailClicked,
    this.emailReplied,
    this.emailBounced,
  });

  factory VCs.fromJson(Map<String, dynamic> json) => VCs(
        vcId: json["vcId"],
        email: json["email"],
        name: json["name"],
        status: json["status"],
        emailOpened: json["emailOpened"],
        emailClicked: json["emailClicked"],
        emailReplied: json["emailReplied"],
        emailBounced: json["emailBounced"],
      );
}
