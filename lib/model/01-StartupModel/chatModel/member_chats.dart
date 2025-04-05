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
  OneLinkRequest? oneLinkRequest;

  ChatMessage({
    this.chatId,
    required this.senderId,
    required this.text,
    required this.attachmentType,
    this.messageId,
    this.attachmentUrl,
    required this.timestamp,
    this.oneLinkRequest,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        senderId: json["sender_id"],
        messageId: json["message_id"],
        text: json["text"],
        attachmentType: attachmentTypeValues.map[json["attachment_type"]]!,
        attachmentUrl: json["attachment_url"],
        timestamp: json["timestamp"],
        oneLinkRequest: json["oneLinkRequest"] != null
            ? OneLinkRequest.fromJson(json["oneLinkRequest"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "chatId": chatId,
        "sender_id": senderId,
        "text": text,
        "attachment_type": attachmentTypeValues.reverse[attachmentType],
        "attachment_url": attachmentUrl,
        "timestamp": timestamp,
        "oneLinkRequest": oneLinkRequest?.toJson(),
      };
}

class OneLinkRequest {
  String? onelinkStatus;
  bool? isFounder;
  String? requestId;
  String? onelinkSecretKey;
  String? startUpId;
  String? onelinkUrl;

  OneLinkRequest({
    this.onelinkStatus,
    this.isFounder,
    this.requestId,
    this.onelinkSecretKey,
    this.startUpId,
    this.onelinkUrl,
  });

  factory OneLinkRequest.fromJson(Map<String, dynamic> json) => OneLinkRequest(
        onelinkStatus: json["onelinkStatus"],
        isFounder: json["isFounder"],
        requestId: json["requestId"],
        startUpId: json["startUpId"],
        onelinkSecretKey: json["onelinkSecretKey"],
        onelinkUrl: json["onelinkUrl"],
      );

  Map<String, dynamic> toJson() => {
        "onelinkStatus": onelinkStatus,
        "isFounder": isFounder,
        "requestId": requestId,
        "startUpId": startUpId,
      };
}

enum MessageType { text, image, video, document, oneLink }

final attachmentTypeValues = EnumValues({
  "document": MessageType.document,
  "image": MessageType.image,
  "text": MessageType.text,
  "video": MessageType.video,
  "oneLink": MessageType.oneLink
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map) {
    reverseMap = map.map((k, v) => MapEntry(v, k));
  }

  Map<T, String> get reverse => reverseMap;
}
