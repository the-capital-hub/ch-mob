import 'dart:convert';

GetYourQuestionsModel getYourQuestionsModelFromJson(String str) => GetYourQuestionsModel.fromJson(json.decode(str));

String getYourQuestionsModelToJson(GetYourQuestionsModel data) => json.encode(data.toJson());

class GetYourQuestionsModel {
  bool status;
  String message;
  YourQuestions? data;

  GetYourQuestionsModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory GetYourQuestionsModel.fromJson(Map<String, dynamic> json) => GetYourQuestionsModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] != null ? YourQuestions.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class YourQuestions {
  String? dmTitle;
  int? timeline;
  List<DMQuestion>? questions;

  YourQuestions({
    this.dmTitle,
    this.timeline,
    this.questions,
  });

  factory YourQuestions.fromJson(Map<String, dynamic> json) => YourQuestions(
    dmTitle: json["dmTitle"],
    timeline: json["timeline"],
    questions: json["questions"] != null
        ? List<DMQuestion>.from(json["questions"].map((x) => DMQuestion.fromJson(x)))
        : null,
  );

  Map<String, dynamic> toJson() => {
    "dmTitle": dmTitle,
    "timeline": timeline,
    "questions": questions != null ? List<dynamic>.from(questions!.map((x) => x.toJson())) : [],
  };
}

class DMQuestion {
  String? id;
  String? question;
  String? answer;
  bool? isAnswered;
  DateTime? createdAt;
  String? timeLeft;
  String? timeAgo;

  DMQuestion({
    this.id,
    this.question,
    this.answer,
    this.isAnswered,
    this.createdAt,
    this.timeLeft,
    this.timeAgo,
  });

  factory DMQuestion.fromJson(Map<String, dynamic> json) => DMQuestion(
    id: json["_id"],
    question: json["question"],
    answer: json["answer"],
    isAnswered: json["isAnswered"],
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
    timeLeft: json["timeLeft"],
    timeAgo: json["timeAgo"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "question": question,
    "answer": answer,
    "isAnswered": isAnswered,
    "createdAt": createdAt?.toIso8601String(),
    "timeLeft": timeLeft,
    "timeAgo": timeAgo,
  };
}
