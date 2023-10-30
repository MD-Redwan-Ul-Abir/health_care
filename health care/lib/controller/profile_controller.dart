import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../model/response_profile_details.dart';
import '../utils/custom_toast.dart';

class ProfileController extends GetxController{

  String baseUrl = 'https://hiyehealth.com/api';
  bool isLoading = false;
  var token = Hive.box("accounts").get('token') ?? Hive.box('login').get('token');
  List<RpProfileDetails> profileDetailsList = [];

  Future<void> getProfileDetails() async {
    isLoading = true;
    update();
    final response = await http.get(Uri.parse('$baseUrl/profile'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var data = rpProfileDetailsFromJson(response.body);
      profileDetailsList.clear();
      profileDetailsList.add(data);
      isLoading = false;
      update();
      print(profileDetailsList[0].data?.name);
    } else {
      isLoading = false;
      update();
      customToast(msg: "Something went wrong", isError: true);
    }
  }

}