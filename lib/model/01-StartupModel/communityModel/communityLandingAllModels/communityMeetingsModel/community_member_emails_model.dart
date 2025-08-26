
import 'dart:convert';

GetMemberEmailModel getMemberEmailModelFromJson(String str) => GetMemberEmailModel.fromJson(json.decode(str));

String getMemberEmailModelToJson(GetMemberEmailModel data) => json.encode(data.toJson());

class GetMemberEmailModel {
    bool status;
    String message;
    List<MemberEmail> data;

    GetMemberEmailModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetMemberEmailModel.fromJson(Map<String, dynamic> json) => GetMemberEmailModel(
        status: json["status"],
        message: json["message"],
        data: List<MemberEmail>.from(json["data"].map((x) => MemberEmail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class MemberEmail {
    String memberName;
    String memberEmail;

    MemberEmail({
        required this.memberName,
        required this.memberEmail,
    });

    factory MemberEmail.fromJson(Map<String, dynamic> json) => MemberEmail(
        memberName: json["memberName"],
        memberEmail: json["memberEmail"],
    );

    Map<String, dynamic> toJson() => {
        "memberName": memberName,
        "memberEmail": memberEmail,
    };
}
