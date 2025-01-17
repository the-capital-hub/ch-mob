// To parse this JSON data, do
//
//     final chatMemberList = chatMemberListFromJson(jsonString);

import 'dart:convert';

ChatMemberList chatMemberListFromJson(String str) =>
    ChatMemberList.fromJson(json.decode(str));

String chatMemberListToJson(ChatMemberList data) => json.encode(data.toJson());

class ChatMemberList {
  bool? status;
  String? message;
  MemberList? data;

  ChatMemberList({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ChatMemberList.fromJson(Map<String, dynamic> json) => ChatMemberList(
        status: json["status"],
        message: json["message"],
        data: MemberList.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class MemberList {
  List<ChatMember>? pinnedChats;
  List<ChatMember>? normalChats;

  MemberList({
    required this.pinnedChats,
    required this.normalChats,
  });

  factory MemberList.fromJson(Map<String, dynamic> json) => MemberList(
        pinnedChats: List<ChatMember>.from(
            json["pinnedChats"].map((x) => ChatMember.fromJson(x))),
        normalChats: List<ChatMember>.from(
            json["normalChats"].map((x) => ChatMember.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pinnedChats": List<dynamic>.from(pinnedChats!.map((x) => x.toJson())),
        "normalChats": List<dynamic>.from(normalChats!.map((x) => x.toJson())),
      };
}

class ChatMember {
  String chatId;
  bool isBlockByMe;
  bool isBlockByOtheUser;
  String senderId;
  String senderImage;
  String senderName;
  String senderDesignation;
  String lastMessage;
  int unreadCount;
  String lastMessageTime;

  ChatMember({
    required this.chatId,
    required this.isBlockByMe,
    required this.isBlockByOtheUser,
    required this.senderId,
    required this.senderImage,
    required this.senderName,
    required this.senderDesignation,
    required this.lastMessage,
    required this.unreadCount,
    required this.lastMessageTime,
  });

  factory ChatMember.fromJson(Map<String, dynamic> json) => ChatMember(
        chatId: json["chatId"],
        isBlockByMe: json["is_blocked_by_me"],
        isBlockByOtheUser: json["is_blocked_by_other_user"],
        senderId: json["sender_id"],
        senderImage: json["senderImage"],
        senderName: json["senderName"],
        senderDesignation: json["senderDesignation"],
        lastMessage: json["lastMessage"],
        unreadCount: json["unreadCount"],
        lastMessageTime: json["lastMessageTime"],
      );

  Map<String, dynamic> toJson() => {
        "chatId": chatId,
        "senderImage": senderImage,
        "senderName": senderName,
        "lastMessage": lastMessage,
        "unreadCount": unreadCount,
        "lastMessageTime": lastMessageTime,
      };
}
