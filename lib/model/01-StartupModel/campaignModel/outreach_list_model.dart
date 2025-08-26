import 'dart:convert';
import 'dart:typed_data';

OutreachListModel outreachListModelFromJson(String str) =>
    OutreachListModel.fromJson(json.decode(str));

String outreachListModelToJson(OutreachListModel data) =>
    json.encode(data.toJson());

class OutreachListModel {
  List<OutreachData>? data;
  bool? status;
  String? message;

  OutreachListModel({
    this.data,
    this.status,
    this.message,
  });

  factory OutreachListModel.fromJson(Map<String, dynamic> json) =>
      OutreachListModel(
        data: json["data"] == null
            ? []
            : List<OutreachData>.from(
                json["data"]!.map((x) => OutreachData.fromJson(x))),
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

class OutreachData {
  String? campaignId;
  CurrentStatus? status;
  String? campaignName;
  String? recipients;
  String? openRate;
  String? replyRate;

  OutreachData({
    this.campaignId,
    this.status,
    this.campaignName,
    this.recipients,
    this.openRate,
    this.replyRate,
  });

  factory OutreachData.fromJson(Map<String, dynamic> json) => OutreachData(
        campaignId: json["campaignId"],
        status: json["status"] == null
            ? null
            : CurrentStatus.fromString(json["status"]),
        campaignName: json["campaignName"],
        recipients: json["recipients"],
        openRate: json["openRate"],
        replyRate: json["replyRate"],
      );

  Map<String, dynamic> toJson() => {
        "campaignId": campaignId,
        "status": status?.toFormattedString(),
        "campaignName": campaignName,
        "recipients": recipients,
        "openRate": openRate,
        "replyRate": replyRate,
      };
}

enum CurrentStatus {
  draft,
  completed,
  scheduled,
  cancelled;

  static CurrentStatus fromString(String status) {
    return CurrentStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == status.replaceAll(' ', '').toLowerCase(),
      orElse: () => CurrentStatus.draft,
    );
  }

  String toFormattedString() {
    return name[0].toUpperCase() + name.substring(1);
  }
}
