import 'dart:convert';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:patient_health_care/view/home/Home.dart';
import 'package:patient_health_care/model/response_login.dart';
import 'package:patient_health_care/utils/custom_toast.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  String baseUrl = 'https://hiyehealth.com/api';
  final Box _boxLogin = Hive.box('login');
  final Box _boxRegister = Hive.box('accounts');
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
        _boxRegister.put('name', loginModel.data!.name);
        _boxRegister.put(email, password);
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

  // void logout() async {
  //   loginData.delete('token');
  //   loginData.delete('name');
  //   Get.offAll(() => const Login());
  // }

  saveUserData() {}
}
