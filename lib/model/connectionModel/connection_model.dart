import 'dart:convert';

ConnectionModel connectionModelFromJson(String str) =>
    ConnectionModel.fromJson(json.decode(str));

String connectionModelToJson(ConnectionModel data) =>
    json.encode(data.toJson());

class ConnectionModel {
  bool? status;
  String? message;
  List<ConnectionData>? data;

  ConnectionModel({
    this.status,
    this.message,
    this.data,
  });

  factory ConnectionModel.fromJson(Map<String, dynamic> json) =>
      ConnectionModel(
        status: json["status"],
        message: json["message"],
        data: List<ConnectionData>.from(
            json["data"].map((x) => ConnectionData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ConnectionData {
  String? connectionId;
  String? id;
  String? firstName;
  String? lastName;
  String? profilePicture;
  String? createdAt;
  String? designation;

  ConnectionData(
      {this.connectionId,
      this.id,
      this.firstName,
      this.lastName,
      this.profilePicture,
      this.createdAt,
      this.designation});

  factory ConnectionData.fromJson(Map<String, dynamic> json) => ConnectionData(
        connectionId: json["connectionId"],
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePicture: json["profilePicture"],
        createdAt: json["createdAt"],
        designation: json["designation"],
      );

  Map<String, dynamic> toJson() => {
        "connectionId": connectionId,
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture,
        "createdAt": createdAt,
      };
}
