// To parse this JSON data, do
//
//     final rpProfileDetails = rpProfileDetailsFromJson(jsonString);

import 'dart:convert';

RpProfileDetails rpProfileDetailsFromJson(String str) => RpProfileDetails.fromJson(json.decode(str));

String rpProfileDetailsToJson(RpProfileDetails data) => json.encode(data.toJson());

class RpProfileDetails {
  final bool? success;
  final Data? data;

  RpProfileDetails({
    this.success,
    this.data,
  });

  factory RpProfileDetails.fromJson(Map<String, dynamic> json) => RpProfileDetails(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  final int? id;
  final String? name;
  final String? email;
  final dynamic emailVerifiedAt;
  final dynamic phone;
  final dynamic image;
  final String? age;
  final String? height;
  final String? gender;
  final String? status;
  final String? type;
  final dynamic filename;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Data({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.image,
    this.age,
    this.height,
    this.gender,
    this.status,
    this.type,
    this.filename,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    phone: json["phone"],
    image: json["image"],
    age: json["age"],
    height: json["height"],
    gender: json["gender"],
    status: json["status"],
    type: json["type"],
    filename: json["filename"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "phone": phone,
    "image": image,
    "age": age,
    "height": height,
    "gender": gender,
    "status": status,
    "type": type,
    "filename": filename,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
