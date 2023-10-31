// To parse this JSON data, do
//
//     final rpLoginModel = rpLoginModelFromJson(jsonString);

import 'dart:convert';

RpLoginModel rpLoginModelFromJson(String str) =>
    RpLoginModel.fromJson(json.decode(str));

String rpLoginModelToJson(RpLoginModel data) => json.encode(data.toJson());

class RpLoginModel {
  final bool? success;
  final Data? data;
  final String? message;

  RpLoginModel({
    this.success,
    this.data,
    this.message,
  });

  factory RpLoginModel.fromJson(Map<String, dynamic> json) => RpLoginModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  final String? token;
  final String? name;
  final int? id;

  Data({
    this.token,
    this.name,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "name": name,
        "id": id,
      };
}
