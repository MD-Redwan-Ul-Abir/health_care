import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:patient_health_care/view/home/Home.dart';
import 'package:patient_health_care/model/responce_dortorlist.dart';
import 'package:patient_health_care/model/response_allquestion.dart';
import 'package:patient_health_care/model/rp_pending_appointment.dart';
import 'package:patient_health_care/utils/custom_toast.dart';

class DoctorController extends GetxController {
  String baseUrl = 'https://hiyehealth.com/api';
  bool isLoading = false;
  List<RpDoctorListmodel> doctorList = [];
  List<AllQuestion> allQuestion = [];
  List<PendingAppt> pendingAppointment = [];
  var token =
      Hive.box("accounts").get('token') ?? Hive.box('login').get('token');
  Future<void> fetchDoctorList() async {
    try {
      var response =
          await http.get(Uri.parse('$baseUrl/doctor_list'), headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var data = rpDoctorListmodelFromJsonList(response.body);
        doctorList.clear();
        doctorList.addAll(data);
        update();
        print(doctorList.length);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> submitQuestion(String question, String dcId) async {
    isLoading = true;
    update();
    var response = await http.post(Uri.parse('$baseUrl/questions'),
        headers: {'Authorization': 'Bearer $token'},
        body: {'question': question, 'doctor_id': dcId});
    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      isLoading = false;
      update();
      print(response.body);
      Get.to(() => const Homepage());
      customToast(msg: body['message']);
    } else {
      isLoading = false;
      update();
      customToast(msg: body['message'], isError: true);
    }
  }

  Future<void> getAllQuestion() async {
    isLoading = true;
    update();
    final response = await http.get(Uri.parse('$baseUrl/question/list'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var data = rpgetAllQuestionFromJson(response.body);
      allQuestion.clear();
      allQuestion.addAll(data.data!);
      isLoading = false;
      update();
      print(data.data!);
    } else {
      isLoading = false;
      update();
      customToast(msg: "Something went wrong", isError: true);
    }
  }

  Future<void> setAppointment(
      String docId, String appointmentdat, String time, String reason) async {
    isLoading = true;
    update();
    var response =
        await http.post(Uri.parse('$baseUrl/make/new/appointments'), headers: {
      'Authorization': 'Bearer $token'
    }, body: {
      'doctor_id': docId,
      'appointment_date': appointmentdat,
      'appointment_time': time,
      'reason': reason
    });
    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      isLoading = false;
      update();
      Get.to(() => const Homepage());
      customToast(msg: body['message']);
    } else {
      isLoading = false;
      update();
      customToast(msg: body['message'], isError: true);
    }
  }

  Future<void> fetchPendingAppointment() async {
    isLoading = true;
    update();
    var response = await http
        .get(Uri.parse('$baseUrl/all/pending/appointments'), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var data = rpgetPendingAppointmentFromJson(response.body);
      if (data.data != null && data.data!.isNotEmpty) {
        pendingAppointment.clear();
        pendingAppointment.addAll(data.data!);
        print(pendingAppointment.length);
        isLoading = false;
        update();
        print(data.data!);
      } else {
        pendingAppointment.clear(); // Clear the list if data.data is empty
        isLoading = false;
        update();
        customToast(msg: "No pending appointments found", isError: false);
      }
    } else {
      isLoading = false;
      update();
      customToast(msg: "Something went wrong", isError: true);
    }
  }
}
