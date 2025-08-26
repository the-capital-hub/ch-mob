import 'dart:convert';

import '../homeScreenLandingModel/post_data_model.dart';

SavedPostModel profilePostModelFromJson(String str) =>
    SavedPostModel.fromJson(json.decode(str));

String profilePostModelToJson(SavedPostModel data) =>
    json.encode(data.toJson());

class SavedPostModel {
  bool? status;
  String? message;
  List<PostData>? data;

  SavedPostModel({
    this.status,
    this.message,
    this.data,
  });

  factory SavedPostModel.fromJson(Map<String, dynamic> json) =>
      SavedPostModel(
        status: json["status"],
        message: json["message"],
        data:
            List<PostData>.from(json["data"].map((x) => PostData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
