import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_health_care/controller/Blog_Controller/blog_controller.dart';



class BlogPage extends StatefulWidget {
   const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {

  @override
  void initState() {
    Get.put(BlogController());
    Get.find<BlogController>().fetchBlogDetails();
    super.initState();
  }

  // BlogController myBlogController = Get.put(BlogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Read something health related"),),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GetBuilder<BlogController>(
          builder: (myBlogController){
            return myBlogController.isLoading ?
            CircularProgressIndicator() :
            ListView(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                    itemCount: myBlogController.blogList[0].blog!.length,
                    itemBuilder: (context, index){
                      return Column(
                        children: [
                          Text(myBlogController.blogList[0].blog![index].title ?? ""),
                        ],
                      );
                    }
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
