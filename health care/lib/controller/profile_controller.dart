import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../model/response_profile_details.dart';
import '../utils/custom_toast.dart';

class ProfileController extends GetxController {
  String baseUrl = 'https://hiyehealth.com/api';
  bool isLoading = false;
  var token =
      Hive.box("accounts").get('token') ?? Hive.box('login').get('token');
  List<RpProfileDetails> profileDetailsList = [];

  Future<void> getProfileDetails() async {
    try {
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
    } catch (e) {
      isLoading = false;
      update();
      print("Error: $e");
    }
  }

  Future<void> updateProfile(String name, String email, XFile? image) async {
    try {
      isLoading = true;
      update();
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/update/profile'),
      );
      request.headers.addAll({'Authorization': 'Bearer $token'});
      request.fields['name'] = name;
      request.fields['email'] = email;
      if (image != null) {
        final fileName = image.path.split('/').last;
        request.files.add(await http.MultipartFile.fromPath('image', image.path,
            filename: fileName));
      }
      final response = await request.send();
      if (response.statusCode == 200) {
        customToast(msg: "Profile Updated Successfully");
        getProfileDetails();
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
        customToast(msg: "Something went wrong", isError: true);
      }
    } catch (e) {
      print(e);
    }
  }
}
