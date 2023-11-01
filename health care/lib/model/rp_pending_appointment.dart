// To parse this JSON data, do
//
//     final rpgetPendingAppointment = rpgetPendingAppointmentFromJson(jsonString);

import 'dart:convert';

RpgetPendingAppointment rpgetPendingAppointmentFromJson(String str) =>
    RpgetPendingAppointment.fromJson(json.decode(str));

String rpgetPendingAppointmentToJson(RpgetPendingAppointment data) =>
    json.encode(data.toJson());

class RpgetPendingAppointment {
  final String? status;
  final List<PendingAppt>? data;

  RpgetPendingAppointment({
    this.status,
    this.data,
  });

  factory RpgetPendingAppointment.fromJson(Map<String, dynamic> json) =>
      RpgetPendingAppointment(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<PendingAppt>.from(
                json["data"]!.map((x) => PendingAppt.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PendingAppt {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? docId;
  final String? userId;
  final DateTime? appointmentDate;
  final String? appointmentTime;
  final String? reason;
  final String? status;
  final dynamic createdAt;
  final dynamic updatedAt;

  PendingAppt({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.docId,
    this.userId,
    this.appointmentDate,
    this.appointmentTime,
    this.reason,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory PendingAppt.fromJson(Map<String, dynamic> json) => PendingAppt(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        docId: json["doc_id"],
        userId: json["user_id"],
        appointmentDate: json["appointment_date"] == null
            ? null
            : DateTime.parse(json["appointment_date"]),
        appointmentTime: json["appointment_time"],
        reason: json["reason"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "doc_id": docId,
        "user_id": userId,
        "appointment_date":
            "${appointmentDate!.year.toString().padLeft(4, '0')}-${appointmentDate!.month.toString().padLeft(2, '0')}-${appointmentDate!.day.toString().padLeft(2, '0')}",
        "appointment_time": appointmentTime,
        "reason": reason,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
