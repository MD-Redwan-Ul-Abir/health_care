import 'dart:convert';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:patient_health_care/view/home/Home.dart';
import 'package:patient_health_care/model/response_login.dart';
import 'package:patient_health_care/utils/custom_toast.dart';

import '../view/registration/forgetPassword/code_verification.dart';
import '../view/registration/forgetPassword/set_new_password.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  String baseUrl = 'https://hiyehealth.com/api';
  final Box _boxLogin = Hive.box('login');
  final Box _boxRegister = Hive.box('accounts');
  final Box _profile = Hive.box("profileDetails");
  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/login'),
        body: {
          'email': email,
          'password': password,
        },
      );
      final RpLoginModel loginModel =
          RpLoginModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        _boxLogin.put('token', loginModel.data!.token!.split('|')[1]);
        _boxLogin.put('name', loginModel.data!.name);
        _boxLogin.put('email', email);
        _boxLogin.put(email, password);
        customToast(msg: loginModel.message!);
        Get.offAll(() => const Homepage());
        isLoading.value = false;
      } else {
        customToast(msg: loginModel.message!, isError: true);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> signUpUser(String name, String email, String password,
      String phone, String age, String gender) async {
    isLoading.value = true;
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/register'),
        body: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
          'age': age,
          'gender': gender,
        },
      );
      final RpLoginModel loginModel =
          RpLoginModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        _boxRegister.put('token', loginModel.data!.token!.split('|')[1]);
        _profile.put('name', name);
        _profile.put('email', email);
        _profile.put(name, 'assets/pp.png');

        customToast(msg: loginModel.message!);
        Get.offAll(() => const Homepage());
        isLoading.value = false;
      } else {
        customToast(msg: loginModel.message!, isError: true);
        isLoading.value = false;
      }
    } catch (e) {
      print('error: $e');
      isLoading.value = false;
    }
  }

  Future<void> changePassword(String oldPwd, String password) async {
    isLoading.value = true;
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/change/password'),
        headers: {
          'Authorization': 'Bearer ${_boxLogin.get('token')}',
        },
        body: {
          'old_password': oldPwd,
          'password': password,
          'password_confirmation': password,
        },
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        customToast(msg: data['message']);
        Get.offAll(() => const Homepage());
        isLoading.value = false;
      } else {
        customToast(msg: data['message'], isError: true);
        isLoading.value = false;
      }
    } catch (e) {
      print('error: $e');
      isLoading.value = false;
    }
  }

  Future<void> forgetPassword(
      {String? email,
      String? pwd,
      String? resetToken,
      String? otp,
      bool? isDone,
      required bool isSend}) async {
    isLoading.value = true;
    String url1 = '$baseUrl/otp/send';
    String url2 = '$baseUrl/otp/verify';
    String url3 = '$baseUrl/reset/pass';
    try {
      final response = await http.post(
        Uri.parse(isSend
            ? url1
            : isDone ?? false
                ? url2
                : url3),
        body: isSend
            ? {'email': email}
            : isDone ?? false
                ? {'otp': otp, 'password_reset_token': resetToken}
                : {
                    'password': pwd,
                    'password_confirmation': pwd,
                    'verify_token': resetToken
                  },
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        customToast(msg: data['message']);
        if (isSend == true) {
          _boxRegister.put("resetToken", data['password_reset_token']);
          _boxRegister.put("resetOtp", data['Otp']);
          Get.to(() => const Veryfy());
        } else if (isSend == false && isDone == true) {
          Get.offAll(() => const SetnewPassword());
        } else {
          Get.offAll(() => const Homepage());
        }
        isLoading.value = false;
      } else {
        customToast(msg: 'Invalid or expired OTP!', isError: true);
        isLoading.value = false;
      }
    } catch (e) {
      print('error: $e');
      isLoading.value = false;
    }
  }
}
