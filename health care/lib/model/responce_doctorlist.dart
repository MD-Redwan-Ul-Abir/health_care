// To parse this JSON data, do
//
//     final rpDoctorListmodel = rpDoctorListmodelFromJson(jsonString);

import 'dart:convert';

RpDoctorListmodel rpDoctorListmodelFromJson(String str) =>
    RpDoctorListmodel.fromJson(json.decode(str));

String rpDoctorListmodelToJson(RpDoctorListmodel data) =>
    json.encode(data.toJson());

List<RpDoctorListmodel> rpDoctorListmodelFromJsonList(String str) =>
    List<RpDoctorListmodel>.from(
        json.decode(str).map((x) => RpDoctorListmodel.fromJson(x)));

class RpDoctorListmodel {
  final int? id;
  final String? position;
  final String? speciality;
  final String? userId;
  final DateTime? createdAt;
  final String? docName;
  final String? docEmail;
  final dynamic docPhone;
  final List<Schedule>? schedules;

  RpDoctorListmodel({
    this.id,
    this.position,
    this.speciality,
    this.userId,
    this.createdAt,
    this.docName,
    this.docEmail,
    this.docPhone,
    this.schedules,
  });

  factory RpDoctorListmodel.fromJson(Map<String, dynamic> json) =>
      RpDoctorListmodel(
        id: json["id"],
        position: json["position"],
        speciality: json["speciality"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        docName: json["doc_name"],
        docEmail: json["doc_email"],
        docPhone: json["doc_phone"],
        schedules: json["schedules"] == null
            ? []
            : List<Schedule>.from(
                json["schedules"]!.map((x) => Schedule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "position": position,
        "speciality": speciality,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "doc_name": docName,
        "doc_email": docEmail,
        "doc_phone": docPhone,
        "schedules": schedules == null
            ? []
            : List<dynamic>.from(schedules!.map((x) => x.toJson())),
      };
}

class Schedule {
  final int? id;
  final String? doctorId;
  final String? dayOfWeek;
  final String? startTime;
  final String? endTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Schedule({
    this.id,
    this.doctorId,
    this.dayOfWeek,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        doctorId: json["doctor_id"],
        dayOfWeek: json["day_of_week"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctor_id": doctorId,
        "day_of_week": dayOfWeek,
        "start_time": startTime,
        "end_time": endTime,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
