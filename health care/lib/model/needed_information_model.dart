// To parse this JSON data, do
//
//     final rpProfileDetails = rpProfileDetailsFromJson(jsonString);

import 'dart:convert';

RpProfileDetails rpProfileDetailsFromJson(String str) => RpProfileDetails.fromJson(json.decode(str));

String rpProfileDetailsToJson(RpProfileDetails data) => json.encode(data.toJson());

class RpProfileDetails {
  final String? status;
  final Data? data;

  RpProfileDetails({
    this.status,
    this.data,
  });

  factory RpProfileDetails.fromJson(Map<String, dynamic> json) => RpProfileDetails(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  final UserData? userData;
  final DiabeticsData? diabeticsData;

  Data({
    this.userData,
    this.diabeticsData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userData: json["user_data"] == null ? null : UserData.fromJson(json["user_data"]),
    diabeticsData: json["diabetics_data"] == null ? null : DiabeticsData.fromJson(json["diabetics_data"]),
  );

  Map<String, dynamic> toJson() => {
    "user_data": userData?.toJson(),
    "diabetics_data": diabeticsData?.toJson(),
  };
}

class DiabeticsData {
  final int? id;
  final String? bpSys;
  final String? bpDias;
  final String? dbBeforeMeal;
  final String? dbAfterMeal;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DiabeticsData({
    this.id,
    this.bpSys,
    this.bpDias,
    this.dbBeforeMeal,
    this.dbAfterMeal,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory DiabeticsData.fromJson(Map<String, dynamic> json) => DiabeticsData(
    id: json["id"],
    bpSys: json["bp_sys"],
    bpDias: json["bp_dias"],
    dbBeforeMeal: json["db_before_meal"],
    dbAfterMeal: json["db_after_meal"],
    userId: json["user_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bp_sys": bpSys,
    "bp_dias": bpDias,
    "db_before_meal": dbBeforeMeal,
    "db_after_meal": dbAfterMeal,
    "user_id": userId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class UserData {
  final String? age;
  final String? height;
  final String? gender;

  UserData({
    this.age,
    this.height,
    this.gender,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    age: json["age"],
    height: json["height"],
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "age": age,
    "height": height,
    "gender": gender,
  };
}
