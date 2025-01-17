// To parse this JSON data, do
//
//     final memberChat = memberChatFromJson(jsonString);

import 'dart:convert';

MemberChat memberChatFromJson(String str) =>
    MemberChat.fromJson(json.decode(str));

String memberChatToJson(MemberChat data) => json.encode(data.toJson());

class MemberChat {
  bool status;
  String message;
  List<ChatMessage> data;

  MemberChat({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MemberChat.fromJson(Map<String, dynamic> json) => MemberChat(
        status: json["status"],
        message: json["message"],
        data: List<ChatMessage>.from(
            json["data"].map((x) => ChatMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ChatMessage {
  String? chatId;
  String senderId;
  String? messageId;
  String text;
  MessageType attachmentType;
  String? attachmentUrl;
  String timestamp;

  ChatMessage({
    this.chatId,
    required this.senderId,
    required this.text,
    required this.attachmentType,
    this.messageId,
    this.attachmentUrl,
    required this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        senderId: json["sender_id"],
        messageId: json["message_id"],
        text: json["text"],
        attachmentType: attachmentTypeValues.map[json["attachment_type"]]!,
        attachmentUrl: json["attachment_url"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "chatId": chatId,
        "sender_id": senderId,
        "text": text,
        "attachment_type": attachmentTypeValues.reverse[attachmentType],
        "attachment_url": attachmentUrl,
        "timestamp": timestamp,
      };
}

enum MessageType { text, image, video, document }

final attachmentTypeValues = EnumValues({
  "document": MessageType.document,
  "image": MessageType.image,
  "text": MessageType.text,
  "video": MessageType.video,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map) {
    reverseMap = map.map((k, v) => MapEntry(v, k));
  }

  Map<T, String> get reverse => reverseMap;
}
