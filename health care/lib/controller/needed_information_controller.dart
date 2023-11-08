import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:patient_health_care/model/model_one.dart';
import 'package:patient_health_care/model/response_diabetics_data.dart';
import 'package:patient_health_care/utils/custom_toast.dart';
import 'package:patient_health_care/view/home/Home.dart';

class DiabetesController extends GetxController {
  String baseUrl = 'https://hiyehealth.com/api';
  var token =
      Hive.box("accounts").get('token') ?? Hive.box('login').get('token');
  bool isLoading = false;
  RpDiabeticsData rpDiabeticsData = RpDiabeticsData();
  List<SalesData> dataSet1 = [];
  List<SalesData> dataSet2 = [];

  Future<void> submitAllDetails(Map value) async {
    try {
      isLoading = true;
      update();
      final response = await http.post(
        Uri.parse("$baseUrl/diabatics"),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: value,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        customToast(msg: data["message"]);
        Get.to(() => const Homepage());
        isLoading = false;
        update();
      } else {
        customToast(
            msg: "Something Wend Wrong,\n Please try again!", isError: true);
        isLoading = false;
        update();
      }
    } catch (e) {
      print(e);
      isLoading = false;
      update();
    }
  }

  Future<void> getDiabeticsData() async {
    try {
      isLoading = true;
      update();
      final response = await http.get(Uri.parse("$baseUrl/getData"), headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var data = rpDiabeticsDataFromJson(response.body);
        rpDiabeticsData = data;
        dataSet1 = [
          for (int i = 0; i < data.dates!.length; i++)
            SalesData(
              data.dates![i],
              double.parse(data.valuesBeforeMeal![i]),
              double.parse(data.valuesAfterMeal![i]),
            ),
        ];
        dataSet2 = [
          for (int i = 0; i < data.dates!.length; i++)
            SalesData(
              data.dates![i],
              double.parse(data.valuesbpSys![i]),
              double.parse(data.valuesbpDias![i]),
            ),
        ];
        customToast(msg: "Data Fetched Successfully");
        print(data);
        isLoading = false;
        update();
      } else {
        customToast(
            msg: "Something Wend Wrong,\n Please try again!", isError: true);
        isLoading = false;
        update();
      }
    } catch (e) {
      print(e);
      isLoading = false;
      update();
    }
  }
}
