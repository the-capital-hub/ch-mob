// post_data_model.dart

class PostData {
  String? postId;
  String? description;
  List<String>? media;
  int likes;
  int? commentsCount;
  String? createdAt;
  bool isLikedByMe;
  bool isSavedByMe;
  List<PollOption>? pollOptions;
  List<String>? myVotes;

  int? totalPollVotes;
  User? user;
  List<String>? latestCommenters;

  PostData({
    this.postId,
    this.description,
    this.media,
    required this.likes,
    this.commentsCount,
    this.createdAt,
    required this.isLikedByMe,
    required this.isSavedByMe,
    this.pollOptions,
    this.totalPollVotes,
    this.user,
    this.myVotes,
    this.latestCommenters,
  });

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        postId: json["postId"],
        description: json["description"],
        media: json["media"] == null
            ? []
            : List<String>.from(json["media"].map((x) => x)),
        likes: json["likes"] ?? 0,
        commentsCount: json["commentsCount"],
        createdAt: json["createdAt"],
        isLikedByMe: json["isLikedByMe"] ?? false,
        isSavedByMe: json["isSavedByMe"] ?? false,
        pollOptions: json["pollOptions"] == null
            ? []
            : List<PollOption>.from(
                json["pollOptions"].map((x) => PollOption.fromJson(x))),
        totalPollVotes: json["totalPollVotes"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        latestCommenters: json["latestCommenters"] == null
            ? []
            : List<String>.from(json["latestCommenters"].map((x) => x)),
        myVotes: List<String>.from(json["myVotes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "description": description,
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x)),
        "likes": likes,
        "commentsCount": commentsCount,
        "createdAt": createdAt,
        "isLikedByMe": isLikedByMe,
        "isSavedByMe": isSavedByMe,
        "pollOptions": pollOptions == null
            ? []
            : List<dynamic>.from(pollOptions!.map((x) => x.toJson())),
        "totalPollVotes": totalPollVotes,
        "user": user?.toJson(),
        "latestCommenters": latestCommenters == null
            ? []
            : List<dynamic>.from(latestCommenters!.map((x) => x)),
      };
}

class PollOption {
  String? id;
  String? option;
  int numberOfVotes;
  bool? hasVoted;

  PollOption({
    this.id,
    this.option,
    required this.numberOfVotes,
    this.hasVoted,
  });

  factory PollOption.fromJson(Map<String, dynamic> json) => PollOption(
        id: json["_id"],
        option: json["option"],
        numberOfVotes: json["numberOfVotes"] ?? 0,
        hasVoted: json["hasVoted"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "option": option,
        "numberOfVotes": numberOfVotes,
        "hasVoted": hasVoted,
      };
}

class User {
  String? userId;
  String? firstName;
  String? lastName;
  String? profilePicture;
  String? bio;
  String? companyImage;

  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.bio,
    this.companyImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePicture: json["profilePicture"],
        bio: json["bio"],
        companyImage: json["companyImage"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "profilePicture": profilePicture,
        "bio": bio,
        "companyImage": companyImage,
      };
}
