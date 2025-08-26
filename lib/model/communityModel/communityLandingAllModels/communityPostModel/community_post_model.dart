// To parse this JSON data, do
//
//     final publicPostModel = publicPostModelFromJson(jsonString);

import 'dart:convert';

import 'package:capitalhub_crm/model/communityModel/communityLandingAllModels/communityPostModel/reshare_community_model.dart';

// CommunityPostModel publicPostModelFromJson(String str) =>
//     CommunityPostModel.fromJson(json.decode(str));

// String publicPostModelToJson(CommunityPostModel data) =>
//     json.encode(data.toJson());

// class CommunityPostModel {
//   bool? status;
//   String? message;
//   List<CommunityPost>? data;

//   CommunityPostModel({
//     this.status,
//     this.message,
//     this.data,
//   });

//   factory CommunityPostModel.fromJson(Map<String, dynamic> json) =>
//       CommunityPostModel(
//         status: json["status"],
//         message: json["message"],
//         data: List<CommunityPost>.from(
//             json["data"].map((x) => CommunityPost.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

// class CommunityPost {
//   String? postId;
//   String? postType;
//   bool? isMyPost;
//   String? description;
//   bool? isSaved;
//   bool? isLiked;
//   List<String>? image;
//   String? video_url;
//   String? document_url;
//   List<PollOptionData>? pollOptions;
//   List<String>? myVotes;
//   int? totalVotes;
//   List<Like>? likes;
//   List<Comment>? comments;
//   String? createdAt;
//   String? connectionStatus;
//   String? userId;
//   String? userFirstName;
//   String? userLastName;
//   String? userImage;
//   String? userDesignation;
//   String? userCompany;
//   bool? userIsSubscribed;
//   ResharedCommunityPostData? resharedPostData;

//   CommunityPost(
//       {this.postId,
//       this.postType,
//       this.isMyPost,
//       this.description,
//       this.isSaved,
//       this.isLiked,
//       this.video_url,
//       this.document_url,
//       this.image,
//       this.pollOptions,
//       this.myVotes,
//       this.totalVotes,
//       this.likes,
//       this.comments,
//       this.createdAt,
//       this.connectionStatus,
//       this.userId,
//       this.userFirstName,
//       this.userLastName,
//       this.userImage,
//       this.userDesignation,
//       this.userCompany,
//       this.userIsSubscribed,
//       this.resharedPostData});

//   factory CommunityPost.fromJson(Map<String, dynamic> json) => CommunityPost(
//       postId: json["postId"],
//       postType: json["postType"],
//       isMyPost: json["isMyPost"],
//       description: json["description"],
//       isSaved: json["isSaved"],
//       isLiked: json["isLiked"],
//       image: List<String>.from(json["image"].map((x) => x)),
//       pollOptions: List<PollOptionData>.from(
//           json["pollOptions"].map((x) => PollOptionData.fromJson(x))),
//       myVotes: List<String>.from(json["myVotes"].map((x) => x)),
//       totalVotes: json["totalVotes"],
//       likes: List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
//       comments:
//           List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
//       createdAt: json["createdAt"],
//       connectionStatus: json["connection_status"],
//       document_url: json['documentUrl'],
//       video_url: json['video'],
//       userId: json["userId"],
//       userFirstName: json["userFirstName"],
//       userLastName: json["userLastName"],
//       userImage: json["userImage"],
//       userDesignation: json["userDesignation"],
//       userCompany: json["userCompany"],
//       userIsSubscribed: json["userIsSubscribed"]??false,
//       resharedPostData: json["resharedPostData"] != null
//           ? ResharedCommunityPostData.fromJson(json["resharedPostData"])
//           : null);

//   Map<String, dynamic> toJson() => {
//         "postId": postId,
//         "postType": postType,
//         "isMyPost": isMyPost,
//         "description": description,
//         "isSaved": isSaved,
//         "isLiked": isLiked,
//         "image": List<dynamic>.from(image!.map((x) => x)),
//         "pollOptions": List<dynamic>.from(pollOptions!.map((x) => x.toJson())),
//         "myVotes": List<dynamic>.from(myVotes!.map((x) => x)),
//         "totalVotes": totalVotes,
//         "likes": List<dynamic>.from(likes!.map((x) => x.toJson())),
//         "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
//         "createdAt": createdAt,
//         "userId": userId,
//         "userFirstName": userFirstName,
//         "userLastName": userLastName,
//         "userImage": userImage,
//         "userDesignation": userDesignation,
//         "userCompany": userCompany,
//         "userIsSubscribed": userIsSubscribed,
//       };
// }

// class Comment {
//   String? id;
//   String? text;
//   String? user;
//   String? userDesignation;
//   String? userCompany;
//   String? userImage;
//   String? createdAt;
//   String? likesCount;
//   bool? isMyComment;
//   bool? isLiked;

//   Comment({
//     this.id,
//     this.text,
//     this.user,
//     this.userDesignation,
//     this.userCompany,
//     this.userImage,
//     this.createdAt,
//     this.likesCount,
//     this.isMyComment,
//     this.isLiked,
//   });

//   factory Comment.fromJson(Map<String, dynamic> json) => Comment(
//         id: json["_id"],
//         text: json["text"],
//         user: json["user"],
//         userDesignation: json["userDesignation"],
//         userCompany: json["userCompany"],
//         userImage: json["userImage"],
//         createdAt: json["createdAt"],
//         likesCount: json["likesCount"],
//         isMyComment: json["isMyComment"],
//         isLiked: json["isLiked"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "text": text,
//         "user": user,
//         "userDesignation": userDesignation,
//         "userCompany": userCompany,
//         "userImage": userImage,
//         "createdAt": createdAt,
//         "likesCount": likesCount,
//         "isMyComment": isMyComment,
//         "isLiked": isLiked,
//       };
// }

// class Like {
//   String? id;
//   String? firstName;
//   String? lastName;

//   Like({
//     this.id,
//     this.firstName,
//     this.lastName,
//   });

//   factory Like.fromJson(Map<String, dynamic> json) => Like(
//         id: json["_id"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "firstName": firstName,
//         "lastName": lastName,
//       };
// }

// class PollOptionData {
//   String? id;
//   String? option;
//   int numberOfVotes;
//   bool? hasVoted;

//   PollOptionData({
//     this.id,
//     this.option,
//     required this.numberOfVotes,
//     this.hasVoted,
//   });

//   factory PollOptionData.fromJson(Map<String, dynamic> json) => PollOptionData(
//         id: json["_id"],
//         option: json["option"],
//         numberOfVotes: json["numberOfVotes"] ?? 0,
//         hasVoted: json["hasVoted"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "option": option,
//         "numberOfVotes": numberOfVotes,
//         "hasVoted": hasVoted,
//       };
// }
// To parse this JSON data, do

//     final communityPostModel = communityPostModelFromJson(jsonString);

// CommunityPostModel communityPostModelFromJson(String str) => CommunityPostModel.fromJson(json.decode(str));

// String communityPostModelToJson(CommunityPostModel data) => json.encode(data.toJson());

// class CommunityPostModel {
//     bool status;
//     String message;
//     CommunityPost data;

//     CommunityPostModel({
//         required this.status,
//         required this.message,
//         required this.data,
//     });

//     factory CommunityPostModel.fromJson(Map<String, dynamic> json) => CommunityPostModel(
//         status: json["status"],
//         message: json["message"],
//         data: CommunityPost.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data.toJson(),
//     };
// }

// class CommunityPost {
//     List<Post> postData;
//     Community communityData;

//     CommunityPost({
//         required this.postData,
//         required this.communityData,
//     });

//     factory CommunityPost.fromJson(Map<String, dynamic> json) => CommunityPost(
//         postData: List<Post>.from(json["postData"].map((x) => Post.fromJson(x))),
//         communityData: Community.fromJson(json["communityData"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "postData": List<dynamic>.from(postData.map((x) => x.toJson())),
//         "communityData": communityData.toJson(),
//     };
// }

// class Community {
//     String id;
//     String name;
//     String whatsappGroupLink;

//     Community({
//         required this.id,
//         required this.name,
//         required this.whatsappGroupLink,
//     });

//     factory Community.fromJson(Map<String, dynamic> json) => Community(
//         id: json["_id"],
//         name: json["name"],
//         whatsappGroupLink: json["whatsapp_group_link"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//         "whatsapp_group_link": whatsappGroupLink,
//     };
// }

// class Post {
//     String postId;
//     String postType;
//     bool isMyPost;
//     String description;
//     bool isSaved;
//     bool isLiked;
//     List<String> image;
//     String video;
//     String documentUrl;
//     List<PollOptionData> pollOptions;
//     List<String> myVotes;
//     int totalVotes;
//     List<Like> likes;
//     List<Comment> comments;
//     String createdAt;
//     String userId;
//     String userFirstName;
//     String userLastName;
//     String userImage;
//     String userDesignation;
//     String userCompany;
//     bool userIsSubscribed;
//     String connectionStatus;
//     ResharedCommunityPostData resharedPostData;

//     Post({
//         required this.postId,
//         required this.postType,
//         required this.isMyPost,
//         required this.description,
//         required this.isSaved,
//         required this.isLiked,
//         required this.image,
//         required this.video,
//         required this.documentUrl,
//         required this.pollOptions,
//         required this.myVotes,
//         required this.totalVotes,
//         required this.likes,
//         required this.comments,
//         required this.createdAt,
//         required this.userId,
//         required this.userFirstName,
//         required this.userLastName,
//         required this.userImage,
//         required this.userDesignation,
//         required this.userCompany,
//         required this.userIsSubscribed,
//         required this.connectionStatus,
//         required this.resharedPostData,
//     });

//     factory Post.fromJson(Map<String, dynamic> json) => Post(
//         postId: json["postId"],
//         postType: json["postType"],
//         isMyPost: json["isMyPost"],
//         description: json["description"],
//         isSaved: json["isSaved"],
//         isLiked: json["isLiked"],
//         image: List<String>.from(json["image"].map((x) => x)),
//         video: json["video"],
//         documentUrl: json["documentUrl"],
//        pollOptions: List<PollOptionData>.from(
//           json["pollOptions"].map((x) => PollOptionData.fromJson(x))),
//         myVotes: List<String>.from(json["myVotes"].map((x) => x)),
//         totalVotes: json["totalVotes"],
//         likes: List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
//         comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
//         createdAt: json["createdAt"],
//         userId: json["userId"],
//         userFirstName: json["userFirstName"],
//         userLastName: json["userLastName"],
//         userImage: json["userImage"],
//         userDesignation: json["userDesignation"],
//         userCompany: json["userCompany"],
//         userIsSubscribed: json["userIsSubscribed"],
//         connectionStatus: json["connection_status"],
//         resharedPostData: ResharedCommunityPostData.fromJson(json["resharedPostData"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "postId": postId,
//         "postType": postType,
//         "isMyPost": isMyPost,
//         "description": description,
//         "isSaved": isSaved,
//         "isLiked": isLiked,
//         "image": List<dynamic>.from(image.map((x) => x)),
//         "video": video,
//         "documentUrl": documentUrl,
//         "pollOptions": List<dynamic>.from(pollOptions.map((x) => x.toJson())),
//         "myVotes": List<dynamic>.from(myVotes.map((x) => x)),
//         "totalVotes": totalVotes,
//         "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
//         "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
//         "createdAt": createdAt,
//         "userId": userId,
//         "userFirstName": userFirstName,
//         "userLastName": userLastName,
//         "userImage": userImage,
//         "userDesignation": userDesignation,
//         "userCompany": userCompany,
//         "userIsSubscribed": userIsSubscribed,
//         "connection_status": connectionStatus,
//         "resharedPostData": resharedPostData.toJson(),
//     };
// }

// class Comment {
//     String id;
//     String text;
//     String user;
//     String userDesignation;
//     String userCompany;
//     String userImage;
//     String createdAt;
//     String likesCount;
//     bool isMyComment;
//     bool isLiked;

//     Comment({
//         required this.id,
//         required this.text,
//         required this.user,
//         required this.userDesignation,
//         required this.userCompany,
//         required this.userImage,
//         required this.createdAt,
//         required this.likesCount,
//         required this.isMyComment,
//         required this.isLiked,
//     });

//     factory Comment.fromJson(Map<String, dynamic> json) => Comment(
//         id: json["_id"],
//         text: json["text"],
//         user: json["user"],
//         userDesignation: json["userDesignation"],
//         userCompany: json["userCompany"],
//         userImage: json["userImage"],
//         createdAt: json["createdAt"],
//         likesCount: json["likesCount"],
//         isMyComment: json["isMyComment"],
//         isLiked: json["isLiked"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "text": text,
//         "user": user,
//         "userDesignation": userDesignation,
//         "userCompany": userCompany,
//         "userImage": userImage,
//         "createdAt": createdAt,
//         "likesCount": likesCount,
//         "isMyComment": isMyComment,
//         "isLiked": isLiked,
//     };
// }

// class Like {
//     String id;
//     String firstName;
//     String lastName;

//     Like({
//         required this.id,
//         required this.firstName,
//         required this.lastName,
//     });

//     factory Like.fromJson(Map<String, dynamic> json) => Like(
//         id: json["_id"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "firstName": firstName,
//         "lastName": lastName,
//     };
// }

// class PollOptionData {
//   String? id;
//   String? option;
//   int numberOfVotes;
//   bool? hasVoted;

//   PollOptionData({
//     this.id,
//     this.option,
//     required this.numberOfVotes,
//     this.hasVoted,
//   });

//   factory PollOptionData.fromJson(Map<String, dynamic> json) => PollOptionData(
//         id: json["_id"],
//         option: json["option"],
//         numberOfVotes: json["numberOfVotes"] ?? 0,
//         hasVoted: json["hasVoted"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "option": option,
//         "numberOfVotes": numberOfVotes,
//         "hasVoted": hasVoted,
//       };
// }

// class ResharedPostData {
//     ResharedPostData();

//     factory ResharedPostData.fromJson(Map<String, dynamic> json) => ResharedPostData(
//     );

//     Map<String, dynamic> toJson() => {
//     };
// }

// class PollOption {
//     String id;
//     String option;
//     int numberOfVotes;
//     bool hasVoted;

//     PollOption({
//         required this.id,
//         required this.option,
//         required this.numberOfVotes,
//         required this.hasVoted,
//     });

//     factory PollOption.fromJson(Map<String, dynamic> json) => PollOption(
//         id: json["_id"],
//         option: json["option"],
//         numberOfVotes: json["numberOfVotes"],
//         hasVoted: json["hasVoted"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "option": option,
//         "numberOfVotes": numberOfVotes,
//         "hasVoted": hasVoted,
//     };
// }
import 'dart:convert';

CommunityPostModel communityPostModelFromJson(String str) {
  try {
    return CommunityPostModel.fromJson(json.decode(str));
  } catch (e) {
    // Handle JSON decoding errors
    print("Error decoding JSON: $e");
    return CommunityPostModel(
        status: false,
        message: "Error decoding JSON",
        data: CommunityPost(
            postData: [],
            communityData: Community(id: "", name: "", whatsappGroupLink: "")));
  }
}

String communityPostModelToJson(CommunityPostModel data) {
  try {
    return json.encode(data.toJson());
  } catch (e) {
    // Handle JSON encoding errors
    print("Error encoding JSON: $e");
    return "{}";
  }
}

class CommunityPostModel {
  bool? status;
  String? message;
  CommunityPost? data;

  CommunityPostModel({
    this.status,
    this.message,
    this.data,
  });

  factory CommunityPostModel.fromJson(Map<String, dynamic> json) {
    try {
      return CommunityPostModel(
        status: json["status"] ?? false,
        message: json["message"] ?? '',
        data:
            json["data"] != null ? CommunityPost.fromJson(json["data"]) : null,
      );
    } catch (e) {
      print("Error parsing CommunityPostModel: $e");
      return CommunityPostModel(
          status: false, message: "Error parsing JSON", data: null);
    }
  }

  Map<String, dynamic> toJson() => {
        "status": status ?? false,
        "message": message ?? '',
        "data": data?.toJson() ?? {},
      };
}

class CommunityPost {
  List<HomePost>? postData;
  Community? communityData;

  CommunityPost({
    this.postData,
    this.communityData,
  });

  factory CommunityPost.fromJson(Map<String, dynamic> json) {
    try {
      return CommunityPost(
        postData: json["postData"] != null
            ? List<HomePost>.from(
                json["postData"].map((x) => HomePost.fromJson(x)))
            : [],
        communityData: json["communityData"] != null
            ? Community.fromJson(json["communityData"])
            : null,
      );
    } catch (e) {
      print("Error parsing CommunityPost: $e");
      return CommunityPost(postData: [], communityData: null);
    }
  }

  Map<String, dynamic> toJson() => {
        "postData": postData != null
            ? List<dynamic>.from(postData!.map((x) => x.toJson()))
            : [],
        "communityData": communityData?.toJson() ?? {},
      };
}

class Community {
  String? id;
  String? name;
  String? whatsappGroupLink;

  Community({
    this.id,
    this.name,
    this.whatsappGroupLink,
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    try {
      return Community(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        whatsappGroupLink: json["whatsapp_group_link"] ?? '',
      );
    } catch (e) {
      print("Error parsing Community: $e");
      return Community(id: "", name: "", whatsappGroupLink: "");
    }
  }

  Map<String, dynamic> toJson() => {
        "_id": id ?? '',
        "name": name ?? '',
        "whatsapp_group_link": whatsappGroupLink ?? '',
      };
}

class HomePost {
  String? postId;
  String? postType;
  bool? isMyPost;
  String? description;
  bool? isSaved;
  int? likeCount;
  int? commentCount;
  bool? isLiked;
  List<String>? image;
  String? video;
  String? documentUrl;
  List<PollOptionData>? pollOptions;
  List<String>? myVotes;
  int? totalVotes;
  List<Like>? likes;
  List<Comment>? comments;
  String? createdAt;
  String? userId;
  String? userFirstName;
  String? userLastName;
  String? userImage;
  String? userDesignation;
  String? userCompany;
  bool? userIsSubscribed;
  String? connectionStatus;
  ResharedCommunityPostData? resharedPostData;

  HomePost({
    this.postId,
    this.postType,
    this.isMyPost,
    this.description,
    this.isSaved,
    this.likeCount,
    this.commentCount,
    this.isLiked,
    this.image,
    this.video,
    this.documentUrl,
    this.pollOptions,
    this.myVotes,
    this.totalVotes,
    this.likes,
    this.comments,
    this.createdAt,
    this.userId,
    this.userFirstName,
    this.userLastName,
    this.userImage,
    this.userDesignation,
    this.userCompany,
    this.userIsSubscribed,
    this.connectionStatus,
    this.resharedPostData,
  });

  factory HomePost.fromJson(Map<String, dynamic> json) {
    try {
      return HomePost(
        postId: json["postId"] ?? '',
        postType: json["postType"] ?? '',
        isMyPost: json["isMyPost"] ?? false,
        description: json["description"] ?? '',
        isSaved: json["isSaved"] ?? false,
        isLiked: json["isLiked"] ?? false,
        image: json["image"] != null ? List<String>.from(json["image"]) : [],
        video: json["video"] ?? '',
        documentUrl: json["documentUrl"] ?? '',
        likeCount: json["likeCount"] ?? 0,
        commentCount: json["commentCount"] ?? 0,
        pollOptions: json["pollOptions"] != null
            ? List<PollOptionData>.from(
                json["pollOptions"].map((x) => PollOptionData.fromJson(x)))
            : [],
        myVotes:
            json["myVotes"] != null ? List<String>.from(json["myVotes"]) : [],
        totalVotes: json["totalVotes"] ?? 0,
        likes: json["likes"] != null
            ? List<Like>.from(json["likes"].map((x) => Like.fromJson(x)))
            : [],
        comments: json["comments"] != null
            ? List<Comment>.from(
                json["comments"].map((x) => Comment.fromJson(x)))
            : [],
        createdAt: json["createdAt"] ?? '',
        userId: json["userId"] ?? '',
        userFirstName: json["userFirstName"] ?? '',
        userLastName: json["userLastName"] ?? '',
        userImage: json["userImage"] ?? '',
        userDesignation: json["userDesignation"] ?? '',
        userCompany: json["userCompany"] ?? '',
        userIsSubscribed: json["userIsSubscribed"] ?? false,
        connectionStatus: json["connection_status"] ?? '',
        resharedPostData: json["resharedPostData"] != null
            ? ResharedCommunityPostData.fromJson(json["resharedPostData"])
            : null,
      );
    } catch (e) {
      print("Error parsing Post: $e");
      return HomePost(
        postId: "",
        postType: "",
        isMyPost: false,
        description: "",
        isSaved: false,
        isLiked: false,
        image: [],
        video: "",
        documentUrl: "",
        pollOptions: [],
        myVotes: [],
        totalVotes: 0,
        likes: [],
        comments: [],
        createdAt: "",
        userId: "",
        userFirstName: "",
        userLastName: "",
        userImage: "",
        userDesignation: "",
        userCompany: "",
        userIsSubscribed: false,
        connectionStatus: "",
        resharedPostData: null,
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "postId": postId ?? '',
        "postType": postType ?? '',
        "isMyPost": isMyPost ?? false,
        "description": description ?? '',
        "isSaved": isSaved ?? false,
        "isLiked": isLiked ?? false,
        "image": image != null ? List<dynamic>.from(image!.map((x) => x)) : [],
        "video": video ?? '',
        "documentUrl": documentUrl ?? '',
        "pollOptions": pollOptions != null
            ? List<dynamic>.from(pollOptions!.map((x) => x.toJson()))
            : [],
        "myVotes":
            myVotes != null ? List<dynamic>.from(myVotes!.map((x) => x)) : [],
        "totalVotes": totalVotes ?? 0,
        "likes": likes != null
            ? List<dynamic>.from(likes!.map((x) => x.toJson()))
            : [],
        "comments": comments != null
            ? List<dynamic>.from(comments!.map((x) => x.toJson()))
            : [],
        "createdAt": createdAt ?? '',
        "userId": userId ?? '',
        "userFirstName": userFirstName ?? '',
        "userLastName": userLastName ?? '',
        "userImage": userImage ?? '',
        "userDesignation": userDesignation ?? '',
        "userCompany": userCompany ?? '',
        "userIsSubscribed": userIsSubscribed ?? false,
        "connection_status": connectionStatus ?? '',
        "resharedPostData": resharedPostData?.toJson() ?? {},
      };
}

class Comment {
  String? id;
  String? text;
  String? user;
  String? userDesignation;
  String? userCompany;
  String? userImage;
  String? createdAt;
  String? likesCount;
  bool? isMyComment;
  bool? isLiked;

  Comment({
    this.id,
    this.text,
    this.user,
    this.userDesignation,
    this.userCompany,
    this.userImage,
    this.createdAt,
    this.likesCount,
    this.isMyComment,
    this.isLiked,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    try {
      return Comment(
        id: json["_id"] ?? '',
        text: json["text"] ?? '',
        user: json["user"] ?? '',
        userDesignation: json["userDesignation"] ?? '',
        userCompany: json["userCompany"] ?? '',
        userImage: json["userImage"] ?? '',
        createdAt: json["createdAt"] ?? '',
        likesCount: json["likesCount"] ?? '',
        isMyComment: json["isMyComment"] ?? false,
        isLiked: json["isLiked"] ?? false,
      );
    } catch (e) {
      print("Error parsing Comment: $e");
      return Comment(
        id: "",
        text: "",
        user: "",
        userDesignation: "",
        userCompany: "",
        userImage: "",
        createdAt: "",
        likesCount: "",
        isMyComment: false,
        isLiked: false,
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "_id": id ?? '',
        "text": text ?? '',
        "user": user ?? '',
        "userDesignation": userDesignation ?? '',
        "userCompany": userCompany ?? '',
        "userImage": userImage ?? '',
        "createdAt": createdAt ?? '',
        "likesCount": likesCount ?? '',
        "isMyComment": isMyComment ?? false,
        "isLiked": isLiked ?? false,
      };
}

class Like {
  String? id;
  String? firstName;
  String? lastName;

  Like({
    this.id,
    this.firstName,
    this.lastName,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    try {
      return Like(
        id: json["_id"] ?? '',
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
      );
    } catch (e) {
      print("Error parsing Like: $e");
      return Like(id: "", firstName: "", lastName: "");
    }
  }

  Map<String, dynamic> toJson() => {
        "_id": id ?? '',
        "firstName": firstName ?? '',
        "lastName": lastName ?? '',
      };
}

class PollOptionData {
  String? id;
  String? option;
  int? numberOfVotes;
  bool? hasVoted;

  PollOptionData({
    this.id,
    this.option,
    this.numberOfVotes,
    this.hasVoted,
  });

  factory PollOptionData.fromJson(Map<String, dynamic> json) {
    try {
      return PollOptionData(
        id: json["_id"] ?? '',
        option: json["option"] ?? '',
        numberOfVotes: json["numberOfVotes"] ?? 0,
        hasVoted: json["hasVoted"] ?? false,
      );
    } catch (e) {
      print("Error parsing PollOptionData: $e");
      return PollOptionData(
          id: "", option: "", numberOfVotes: 0, hasVoted: false);
    }
  }

  Map<String, dynamic> toJson() => {
        "_id": id ?? '',
        "option": option ?? '',
        "numberOfVotes": numberOfVotes ?? 0,
        "hasVoted": hasVoted ?? false,
      };
}

class ResharedPostData {
  ResharedPostData();

  factory ResharedPostData.fromJson(Map<String, dynamic> json) =>
      ResharedPostData();

  Map<String, dynamic> toJson() => {};
}
