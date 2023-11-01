import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:patient_health_care/utils/custom_toast.dart';
import 'package:patient_health_care/view/home/Home.dart';

class DiabetesController extends GetxController{
  String baseUrl = 'https://hiyehealth.com/api';
  var token = Hive.box("accounts").get('token') ?? Hive.box('login').get('token');
  bool isLoading = false;


  Future<void> submitAllDetails(Map value) async {
    try{
      isLoading = true;
      update();
      final response = await http.post(
          Uri.parse("${baseUrl}/diabatics"),
          headers: {
            'Authorization': 'Bearer $token',
          },
        body: value,
      );
      
      
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        customToast(msg: data["message"]);
        Get.to(()=>Homepage());
        isLoading = false;
        update();
      }
      else{
        customToast(msg: "Something Wend Wrong,\n Please try again!") ;
        isLoading = false;
        update();
      }
    }
    catch(e){
      print(e);
      isLoading = false;
      update();
    }


}

}