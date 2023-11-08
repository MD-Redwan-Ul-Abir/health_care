// To parse this JSON data, do
//
//     final rpDiabeticsData = rpDiabeticsDataFromJson(jsonString);

import 'dart:convert';

RpDiabeticsData rpDiabeticsDataFromJson(String str) =>
    RpDiabeticsData.fromJson(json.decode(str));

String rpDiabeticsDataToJson(RpDiabeticsData data) =>
    json.encode(data.toJson());

class RpDiabeticsData {
  final String? status;
  final List<String>? dates;
  final List<String>? valuesBeforeMeal;
  final List<String>? valuesAfterMeal;
  final List<String>? valuesbpSys;
  final List<String>? valuesbpDias;

  RpDiabeticsData({
    this.status,
    this.dates,
    this.valuesBeforeMeal,
    this.valuesAfterMeal,
    this.valuesbpSys,
    this.valuesbpDias,
  });

  factory RpDiabeticsData.fromJson(Map<String, dynamic> json) =>
      RpDiabeticsData(
        status: json["status"],
        dates: json["dates"] == null
            ? []
            : List<String>.from(json["dates"]!.map((x) => x)),
        valuesBeforeMeal: json["valuesBeforeMeal"] == null
            ? []
            : List<String>.from(json["valuesBeforeMeal"]!.map((x) => x)),
        valuesAfterMeal: json["valuesAfterMeal"] == null
            ? []
            : List<String>.from(json["valuesAfterMeal"]!.map((x) => x)),
        valuesbpSys: json["valuesbp_sys"] == null
            ? []
            : List<String>.from(json["valuesbp_sys"]!.map((x) => x)),
        valuesbpDias: json["valuesbp_dias"] == null
            ? []
            : List<String>.from(json["valuesbp_dias"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "dates": dates == null ? [] : List<dynamic>.from(dates!.map((x) => x)),
        "valuesBeforeMeal": valuesBeforeMeal == null
            ? []
            : List<dynamic>.from(valuesBeforeMeal!.map((x) => x)),
        "valuesAfterMeal": valuesAfterMeal == null
            ? []
            : List<dynamic>.from(valuesAfterMeal!.map((x) => x)),
        "valuesbp_sys": valuesbpSys == null
            ? []
            : List<dynamic>.from(valuesbpSys!.map((x) => x)),
        "valuesbp_dias": valuesbpDias == null
            ? []
            : List<dynamic>.from(valuesbpDias!.map((x) => x)),
      };
}
