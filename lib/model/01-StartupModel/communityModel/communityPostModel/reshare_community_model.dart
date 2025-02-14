import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityPostModel/community_post_model.dart';

class ResharedCommunityPostData {
  String? userProfilePicture;
  String? userDesignation;
  String? userFirstName;
  String? userLastName;
  String? userLocation;
  String? postId;
  String? description;
  List<String>? images;
  String? age;
  List<PollOptionData>? pollOptions;
  List<String>? myVotes;
  int? totalVotes;

  ResharedCommunityPostData({
    this.userProfilePicture,
    this.userDesignation,
    this.userFirstName,
    this.userLastName,
    this.userLocation,
    this.postId,
    this.description,
    this.images,
    this.age,
    this.pollOptions,
    this.myVotes,
    this.totalVotes,
  });

  factory ResharedCommunityPostData.fromJson(Map<String, dynamic> json) =>
      ResharedCommunityPostData(
        userProfilePicture: json["userProfilePicture"],
        userDesignation: json["userDesignation"],
        userFirstName: json["userFirstName"],
        userLastName: json["userLastName"],
        userLocation: json["userLocation"],
        postId: json["postId"],
        description: json["description"],
        images: json["images"] != null
            ? List<String>.from(json["images"].map((x) => x))
            : null,
        age: json["age"],
        pollOptions: json["pollOptions"] != null
            ? List<PollOptionData>.from(
                json["pollOptions"].map((x) => PollOptionData.fromJson(x)))
            : null,
        myVotes: json["myVotes"] != null
            ? List<String>.from(json["myVotes"].map((x) => x))
            : null,
        totalVotes: json["totalVotes"],
      );

  Map<String, dynamic> toJson() => {
        "userProfilePicture": userProfilePicture,
        "userDesignation": userDesignation,
        "userFirstName": userFirstName,
        "userLastName": userLastName,
        "userLocation": userLocation,
        "postId": postId,
        "description": description,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "age": age,
        "pollOptions": List<dynamic>.from(pollOptions!.map((x) => x.toJson())),
        "myVotes": List<dynamic>.from(myVotes!.map((x) => x)),
        "totalVotes": totalVotes,
      };
  bool isEmpty() {
    return postId == null;
  }
}
