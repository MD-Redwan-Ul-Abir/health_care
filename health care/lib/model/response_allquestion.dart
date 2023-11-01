// To parse this JSON data, do
//
//     final rpgetAllQuestion = rpgetAllQuestionFromJson(jsonString);

import 'dart:convert';

RpgetAllQuestion rpgetAllQuestionFromJson(String str) =>
    RpgetAllQuestion.fromJson(json.decode(str));

String rpgetAllQuestionToJson(RpgetAllQuestion data) =>
    json.encode(data.toJson());

class RpgetAllQuestion {
  final String? status;
  final List<AllQuestion>? data;

  RpgetAllQuestion({
    this.status,
    this.data,
  });

  factory RpgetAllQuestion.fromJson(Map<String, dynamic> json) =>
      RpgetAllQuestion(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<AllQuestion>.from(
                json["data"]!.map((x) => AllQuestion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AllQuestion {
  final int? id;
  final String? userId;
  final String? name;
  final dynamic status;
  final String? question;
  final dynamic answer;
  final String? doctorId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AllQuestion({
    this.id,
    this.userId,
    this.name,
    this.status,
    this.question,
    this.answer,
    this.doctorId,
    this.createdAt,
    this.updatedAt,
  });

  factory AllQuestion.fromJson(Map<String, dynamic> json) => AllQuestion(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        status: json["status"],
        question: json["question"],
        answer: json["answer"],
        doctorId: json["doctor_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "status": status,
        "question": question,
        "answer": answer,
        "doctor_id": doctorId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
