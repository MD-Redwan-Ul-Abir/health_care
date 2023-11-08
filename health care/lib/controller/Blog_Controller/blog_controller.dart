
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../../model/Blog_Model/BlogModel.dart';
import '../../utils/custom_toast.dart';



class BlogController extends GetxController{

  bool isLoading = false;
  String baseurl = "https://www.hiyehealth.com/api";
  List<BlogModel> blogList = [];
  var token = Hive.box("accounts").get('token') ?? Hive.box('login').get('token');

  Future<void> fetchBlogDetails() async {

    isLoading = true;
    update();

    try{
      var response = await http.get(
        Uri.parse("$baseurl/all/blog"),
        headers: {
          'Authorization': 'Bearer $token',
        }
      );

      if(response.statusCode == 200){
        var data = blogModelFromJson(response.body);
        blogList.clear();
        blogList.add(data);
        isLoading = false;
        update();
        print(blogList.length);
      }
      else{
        isLoading = false;
        update();
        customToast(msg: "Something went wrong", isError: true);
      }

    }
    catch(e){
      isLoading = false;
      update();
      print("Something went wrong : ${e.toString()}");
    }
  }



}